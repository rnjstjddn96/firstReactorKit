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
    
    let btnToken =
        UIButton.Builder()
        .withText("GetToken", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    let btnAnimal =
        UIButton.Builder()
        .withText("GetAnimal", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    let btnEvent =
        UIButton.Builder()
        .withText("EventView", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    let btnToast =
        UIButton.Builder()
        .withText("Toast", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    let btnPopup =
        UIButton.Builder()
        .withText("popup", for: .normal)
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
        
        btnToTable.rx.tap
            .map { Reactor.Action.route(to: TableViewController()) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnToken.rx.tap
            .map { _ in
                let param = ["grant_type": "client_credentials",
                             "client_id": "laHKVVf7SD0zx8O5hjVIcDzIwMwcP7CMHnkGcPS5wLu6h10Np0",
                             "client_secret": "ZEhiRKXRyL1WBLXRkCVqkJeYnHvx4AvGcPbucUVE"]
                return Reactor.Action.getToken(param: param)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnAnimal.rx.tap
            .map { _ in
                return Reactor.Action.getAnimal
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnEvent.rx.tap
            .map { Reactor.Action.route(to: EventViewController()) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        btnToast.rx.tap
            .bind {
                ToastMessage.shared.show(message: "토스트")
            }
            .disposed(by: disposeBag)
        
        btnPopup.rx.tap
            .map { Reactor.Action.route(to: PopupViewController()) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .asObservable()
            .map { $0.token }
            .filter { $0 != nil }
            .subscribe(onNext: { token in
                UserDefaultsManager.shared.signIn(apiKey: "laHKVVf7SD0zx8O5hjVIcDzIwMwcP7CMHnkGcPS5wLu6h10Np0",
                                                  secretKey: "ZEhiRKXRyL1WBLXRkCVqkJeYnHvx4AvGcPbucUVE",
                                                  token: token?.access_token ?? "")
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .asObservable()
            .map { $0.allAnimal }
            .filter { $0 != nil }
            .subscribe(onNext: { animal in
                print("Animal : \(animal?.animals?.first?.species?.rawValue ?? "animal empty")")
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .asObservable()
            .map { $0.failure }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] failure in
                guard let self = self else { return }
                self.showAlert(title: failure?.detail ?? "",
                               message: "")
            })
            .disposed(by: disposeBag)

        reactor.state
            .asObservable()
            .map { $0.error }
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(title: error?.localizedDescription ?? "",
                               message: "")
            })
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
            .subscribe(onNext: {
                ViewRouter.route(from: self, to: $0, withNavigation: true)
            })
            .disposed(by: disposeBag)
    }

    private func addSubViews() {
        self.view.addSubview(label)
        self.view.addSubview(btnInc)
        self.view.addSubview(btnDec)
        self.view.addSubview(btnToTable)
        self.view.addSubview(btnToken)
        self.view.addSubview(btnAnimal)
        self.view.addSubview(btnEvent)
        self.view.addSubview(btnToast)
        self.view.addSubview(btnPopup)
        
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
        
        btnToken.snp.makeConstraints { create in
            create.top.equalTo(btnToTable.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
        
        btnAnimal.snp.makeConstraints { create in
            create.top.equalTo(btnToken.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
        
        btnEvent.snp.makeConstraints { create in
            create.top.equalTo(btnAnimal.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
        
        btnToast.snp.makeConstraints { create in
            create.top.equalTo(btnEvent.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
        
        btnPopup.snp.makeConstraints { create in
            create.top.equalTo(label.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
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
