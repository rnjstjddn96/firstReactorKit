//
//  CommonButton.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/08.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CommonButton: UIView {
    let title: String
    let titleColor: UIColor
    let background: UIColor
    let titleFont: UIFont
    var action: (() -> Void)? = nil
    
    var disposeBag = DisposeBag()
    
    init(title: String,
         titleColor: UIColor,
         background: UIColor,
         titleFont: UIFont,
         action: (() -> Void)? = nil,
         frame: CGRect = .zero) {
        self.title = title
        self.titleColor = titleColor
        self.background = background
        self.titleFont = titleFont
        self.action = action
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAction(action: @escaping (() -> Void)) {
        self.action = action
    }
    
    func buildCommonButton() {
        let btn = UIButton.Builder()
            .withText(title, for: .normal)
            .withTextColor(titleColor, for: .normal)
            .withBackground(color: background)
            .withCornerRadius(radius: 10)
            .build()
        
        self.addSubview(btn)
        btn.snp.makeConstraints { create in
            create.left.right.top.bottom.equalToSuperview()
        }
        
        btn.rx.controlEvent(.touchUpInside)
            .asControlEvent()
            .bind { [weak self] in
                guard let self = self else { return }
                guard let _action = self.action else { return }
                _action()
            }
            .disposed(by: disposeBag)
    }
    
}
