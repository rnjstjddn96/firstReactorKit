//
//  HomeViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import UIKit
import ReactorKit
import RxCocoa
import SnapKit

class HomeViewController: BaseViewController<HomeReactor>, View {
    lazy var loadingIndicator = LoadingIndicator(view: self.view)
    var homeNavigationBar = HomeNavigationBar()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let btnInc: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    let btnDec: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        addSubViews()
        configureUI()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(homeNavigationBar)
        homeNavigationBar.snp.makeConstraints { create in
            create.left.right.equalToSuperview()
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            create.height.equalTo(70)
        }
    }
    
    func bind(reactor: HomeReactor) {
        btnInc.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnDec.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        homeNavigationBar.btnMenu.rx
            .controlEvent(.touchUpInside)
            .map {
                let destination = MenuViewController()
                let reactor = MenuViewReactor()
                destination.reactor = reactor
                return Reactor.Action.route(to: destination)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.loadingIndicator.showIndicator(on: $0)
            })
            .disposed(by: disposeBag)
            
        reactor.state
            .map { $0.destination }
            .distinctUntilChanged()
            .bind(onNext: {
                ViewRouter.route(from: self, to: $0, navigateType: .PUSH)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.user }
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
    }

    private func addSubViews() {
        self.view.addSubview(label)
        self.view.addSubview(btnInc)
        self.view.addSubview(btnDec)
        
        label.snp.makeConstraints { create in
            create.center.equalToSuperview()
            create.width.equalTo(50)
        }
        
        btnInc.snp.makeConstraints { create in
            create.left.equalTo(label.snp.right).offset(30)
            create.centerY.equalToSuperview()
        }
        
        btnDec.snp.makeConstraints { create in
            create.right.equalTo(label.snp.left).offset(-30)
            create.centerY.equalToSuperview()
        }
    }
}
