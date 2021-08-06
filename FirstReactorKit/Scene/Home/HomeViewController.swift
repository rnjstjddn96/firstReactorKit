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

class HomeViewController: UIViewController, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    lazy var loadingIndicator = LoadingIndicator(view: self.view)
    
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
    
    let btnToTable =
        UIButton.Builder()
        .withText("RxTables", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        addSubViews()
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
        
//        btnToTable.rx.tap
//            .map { Reactor.Action.route(to: TableViewController()) }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
        
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
            .subscribe(onNext: {
                ViewRouter.route(from: self, to: $0, withNavigation: true)
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
        self.view.addSubview(btnToTable)
        
        self.view.backgroundColor = .orange
        
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
        
        btnToTable.snp.makeConstraints { create in
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
    }
}
