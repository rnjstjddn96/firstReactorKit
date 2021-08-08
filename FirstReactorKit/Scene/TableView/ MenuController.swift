//
//  TableViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa

class MenuViewController: UIViewController {
    lazy var navigationBar = NavigationBar()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        
        navigationBar.btnBack.rx
            .controlEvent(.touchUpInside)
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { create in
            create.left.right.equalToSuperview()
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            create.height.equalTo(70)
        }
    }
    
    
}
