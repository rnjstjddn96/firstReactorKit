//
//  SplashViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import Foundation
import UIKit
import ReactorKit
import RxCocoa

class SplashViewController: UIViewController {
    
    var session = NetworkService()
    var disposeBag = DisposeBag()
    
    var didEnterSplashView = PublishSubject<Void>()
    
    lazy var loadingIndicator = LoadingIndicator(view: self.view)
    let splashLogoView = SplashLogoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        didEnterSplashView.onNext(())
    }
    
    private func showAlert(title: String, message: String) {
        AlertUtils.displayBasicAlert(controller: self,
                                     title: title, message: message,
                                     showCancelButton: false,
                                     okButtonTitle: "확인",
                                     cancelButtonTitle: nil,
                                     okButtonCallback: nil,
                                     cancelButtonCallback: nil)
    }
}

extension SplashViewController: View {
    func bind(reactor: SplashReactor) {
        //MARK: View Interaction 또는 Life Cycle을 Reactor의 Action과 바인딩해준다.
        didEnterSplashView
            .map { _ in
                Reactor.Action.viewWillAppear
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        didEnterSplashView
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .map { _ in
                Reactor.Action.getUser
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        UserManager.current.user
            .skip(1)
            .distinctUntilChanged()
            .observe(on:MainScheduler.asyncInstance)
            .delay(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { _ in
                let destination = MainViewController()
                let reactor = MainReactor()
                destination.reactor = reactor
                return Reactor.Action.route(to: destination)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //MARK: Reactor의 State값 변화를 구독
        reactor.state
            .map { $0.logoShown }
            .skip(1)
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] logoShown in
                guard let self = self else { return }
                if logoShown {
                    self.splashLogoView.initSplashLogo(to: self.view)
                } else {
                    self.splashLogoView.deinitSplashLogo()
                    self.didEnterSplashView.onCompleted()
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .skip(1)
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.loadingIndicator.showIndicator(on: $0)
            })
            .disposed(by: disposeBag)
        

        reactor.state
            .asObservable()
            .skip(1)
            .map { $0.destination }
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { destination in
                ViewRouter.route(from: self, to: destination,
                                 withNavigation: true)
            })
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.user }
            .asObservable()
            .distinctUntilChanged()
            .filter { $0 != nil }
            .subscribe(onNext: {
                UserManager.current.updateUser(user: $0!)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .asObservable()
            .map { $0.failure }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] failure in
                guard let self = self else { return }
                self.showAlert(title: "유저정보를 받아오지 못했습니다.",
                               message: failure?.resultMessage ?? "")
            })
            .disposed(by: disposeBag)

        reactor.state
            .asObservable()
            .map { $0.error }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(title: "유저정보를 받아오지 못했습니다.",
                               message: error?.localizedDescription ?? "")
            })
            .disposed(by: disposeBag)
    }
}
