//
//  BottomMenuViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa

class BottomMenuViewController: UIViewController {

    var bottomMenutapGesture = UITapGestureRecognizer()
    let indicator = BottomMenuIndicator()
    var disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
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
            create.left.right.bottom.equalToSuperview()
        }
        
        setTableView()
        setGesture()
    }
    
    private func setGesture() {
        indicator.addGestureRecognizer(bottomMenutapGesture)
    }
    
    private func setTableView() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.ID)
    }
}

extension BottomMenuViewController: View {
    func bind(reactor: BottomMenuReactor) {
        
        bottomMenutapGesture.rx.event
            .map { _ in
                Reactor.Action.toggleBottomMenu
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
