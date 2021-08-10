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

class SplashViewController: BaseViewController<SplashReactor> {
    
    var session = NetworkService()
    
    lazy var loadingIndicator = LoadingIndicator(view: self.view)
    let splashLogoView = SplashLogoView()
    var btnToLogin = CommonButton(title: "로그인",
                                  titleColor: .white,
                                  background: .systemIndigo,
                                  titleFont: .systemFont(ofSize: 20, weight: .bold))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.on(.next(.showLogo))
        viewWillAppearSubject.on(.next(.getUser))
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
    
    private func configureButtons() {
        self.view.addSubview(btnToLogin)
        btnToLogin.snp.makeConstraints { create in
            create.centerX.equalToSuperview()
            create.bottom.equalToSuperview().offset(-30)
            create.height.equalTo(50)
            create.width.equalToSuperview().multipliedBy(0.8)
        }
        btnToLogin.buildCommonButton()
    }
}

extension SplashViewController: View {
    func bind(reactor: SplashReactor) {
        //MARK: View Interaction 또는 Life Cycle을 Reactor의 Action과 바인딩해준다.
        viewWillAppearSubject
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        UserManager.current.authoriation
            .skip(1)
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .map { authorization in
                let mainView = MainViewController()
                let reactor = MainReactor()
                mainView.reactor = reactor
                let naviagation = UINavigationController(rootViewController: mainView)
                return Reactor.Action.route(to: naviagation)
//                switch authorization {
//                case .AUTHORIZED(user: let user):
//                case .UNAUTHORIZED:
//                }
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //MARK: Reactor의 State값 변화를 구독
        reactor.state
            .map { $0.logoShown }
            .skip(1)
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(onNext: { [weak self] logoShown in
                guard let self = self else { return }
                self.splashLogoView.initSplashLogo(to: self.view)
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
                ViewRouter.route(from: self,
                                 to: destination,
                                 navigateType: .PRESENT,
                                 presentationStyle: .fullScreen,
                                 transitionStyle: .crossDissolve)
            })
            .disposed(by: disposeBag)
        
        
        reactor.state
            .map { $0.user }
            .distinctUntilChanged()
            .filter { $0 != nil }
            .subscribe(onNext: {
                UserManager.current.authorize(user: $0!)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .asObservable()
            .map { $0.failure }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] failure in
                guard let self = self else { return }
                //MARK: Login Register 버튼 생성
                self.configureButtons()
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
