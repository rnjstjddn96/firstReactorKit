//
//  HomeNavigationBar.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/07.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class HomeNavigationBar: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let btnMenu = UIButton.Builder()
        .withFont(.systemFont(ofSize: 15))
        .withText("menu", for: .normal)
        .withTextColor(.black, for: .normal)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        self.addSubview(containerView)
        containerView.addSubview(btnMenu)
        
        containerView.snp.makeConstraints { create in
            create.left.right.top.bottom.equalToSuperview()
        }
        
        btnMenu.snp.makeConstraints { create in
            create.right.bottom.equalToSuperview().offset(-20)
            create.top.equalToSuperview().offset(20)
        }
    }
}
