//
//  ViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/19.
//

import UIKit
import ReactorKit
import RxCocoa
import SnapKit

class ViewController: UIViewController, View {
    var user: User?
    var disposeBag: DisposeBag = DisposeBag()
    
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
    }
    
    func bind(reactor: ViewReactor) {
        btnInc.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnDec.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

    private func addSubViews() {
        self.view.addSubview(label)
        self.view.addSubview(btnInc)
        self.view.addSubview(btnDec)
//        self.view.addSubview(loadingIndicator)
        
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
        
//        loadingIndicator.snp.makeConstraints { create in
//            create.center.equalToSuperview()
//            create.width.equalToSuperview().multipliedBy(0.5)
//            create.height.equalTo(loadingIndicator.snp.width)
//        }
    }
}
