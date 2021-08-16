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

enum NavigationButtonType {
    case back
    case close
    
    var button: UIButton {
        switch self {
        case .back:
            return UIButton().then {
                $0.setTitle("back", for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 15)
                $0.setTitleColor(.black, for: .normal)
            }
        case .close:
            return UIButton().then {
                $0.setTitle("close", for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 15)
                $0.setTitleColor(.black, for: .normal)
            }
        }
    }
}

class NavigationBar: UIView {

    var title: String? = nil
    var leftType: NavigationButtonType? = nil
    var rightType: NavigationButtonType? = nil
    
    lazy var leftButton = leftType?.button
    lazy var rightButton = rightType?.button
    
    init(frame: CGRect,
         title: String?,
         leftType: NavigationButtonType?,
         rightType: NavigationButtonType?) {
        self.title = title
        self.leftType = leftType
        self.rightType = rightType
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = self.title
    }
    
    let containerView = UIView().then {
        $0.backgroundColor = .systemIndigo
    }
    
    func configure() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints { create in
            create.left.right.top.bottom.equalToSuperview()
        }
        
        if let _ = self.title {
            containerView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { [weak self] create in
                guard let self = self else { return }
                create.center.equalTo(containerView)
                create.width.lessThanOrEqualTo(self.containerView.snp.width)
            }
        }
        
        if let _ = self.leftType {
            containerView.addSubview(leftButton!)
            leftButton!.snp.makeConstraints { create in
                create.bottom.equalTo(containerView).offset(-20)
                create.left.top.equalTo(containerView).offset(20)
            }
        }
        
        if let _ = self.rightType {
            containerView.addSubview(rightButton!)
            rightButton!.snp.makeConstraints { create in
                create.bottom.right.equalToSuperview().offset(-20)
                create.top.equalToSuperview().offset(20)
            }
        }
        
    }
}
