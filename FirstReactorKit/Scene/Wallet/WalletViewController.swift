//
//  WalletViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa

class WalletViewController: UIViewController {

    var viewWillAppearSubject = PublishSubject<WalletReactor.Action>()
    var bottomMenutapGesture = UITapGestureRecognizer()
    let indicator = WalletIndicator()
    var disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.ID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 50
        
        self.view.addSubview(indicator)
        self.indicator.snp.makeConstraints { create in
            create.top.left.right.equalToSuperview()
            create.height.equalTo(100)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { create in
            create.top.equalTo(indicator.snp.bottom)
            create.left.right.equalToSuperview()
            create.bottom.equalTo(self.view.snp.bottom)
                .offset(-(WalletIndicator.INDICATOR_HEIGHT + 100))
        }
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        setGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.on(.next(.getTodos))
        viewWillAppearSubject.on(.completed)
    }
    
    private func setGesture() {
        indicator.addGestureRecognizer(bottomMenutapGesture)
    }
}

extension WalletViewController: View {
    func bind(reactor: WalletReactor) {
        let manager = WalletManager.shared
        
        bottomMenutapGesture.rx.event
            .bind(onNext: { _ in
                switch manager.currentState.value {
                case .CLOSED:
                    _ = manager.updateState(event: .openMenu)
                case .EXPANDED:
                    _ = manager.updateState(event: .closeMenu)
                }
            })
            .disposed(by: disposeBag)
        
        viewWillAppearSubject
            .asObservable()
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.todos }
            .bind(to: tableView.rx.items(cellIdentifier: CustomCell.ID,
                                         cellType: CustomCell.self)) { row, todo, cell in
                cell.bindUI(text: todo.title ?? "",
                           image: UIImage(named: "profile")!)
            }
            .disposed(by: disposeBag)
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
