//
//  NavigationBar.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/08.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class NavigationBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let btnBack = UIButton.Builder()
        .withFont(.systemFont(ofSize: 15))
        .withText("back", for: .normal)
        .withTextColor(.black, for: .normal)
        .build()
    
    func configure() {
        self.addSubview(containerView)
        containerView.addSubview(btnBack)
        
        containerView.snp.makeConstraints { create in
            create.left.right.top.bottom.equalToSuperview()
        }
        
        btnBack.snp.makeConstraints { create in
            create.bottom.equalToSuperview().offset(-20)
            create.left.top.equalToSuperview().offset(20)
        }
    }
}
