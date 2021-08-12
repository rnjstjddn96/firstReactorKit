//
//  Divider.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/12.
//

import Foundation
import UIKit
import SnapKit

enum AttachPosition {
    case TOP(guide: ConstraintItem)
    case BOTTOM(guide: ConstraintItem)
    case LEFT(guide: ConstraintItem)
    case RIGHT(guide: ConstraintItem)
}

class Divider: NSObject {
    let view: UIView?
    var color: UIColor = .clear
    var height: CGFloat = 0.0
    var padding: CGFloat = 0.0
    
    lazy var divider = UIView().then { divider in
        divider.backgroundColor = self.color
    }
    
    init(to view: UIView, color: UIColor, height: CGFloat, padding: CGFloat) {
        self.view = view
        self.color = color
        self.height = height
        self.padding = padding
        super.init()
    }
    
    func addDivider(on position: AttachPosition) {
        self.view?.addSubview(divider)
        switch position {
        case .TOP(let guide):
            divider.snp.makeConstraints { create in
                create.left.equalToSuperview().offset(padding)
                create.right.equalToSuperview().offset(-padding)
                create.top.equalTo(guide)
                create.height.equalTo(self.height)
            }
        case .BOTTOM(let guide):
            divider.snp.makeConstraints { create in
                create.left.equalToSuperview().offset(padding)
                create.right.equalToSuperview().offset(-padding)
                create.bottom.equalTo(guide)
                create.height.equalTo(self.height)
            }
        case .LEFT(let guide):
            divider.snp.makeConstraints { create in
                create.top.equalToSuperview().offset(padding)
                create.bottom.equalToSuperview().offset(-padding)
                create.left.equalTo(guide)
                create.width.equalTo(self.height)
            }
        case .RIGHT(let guide):
            divider.snp.makeConstraints { create in
                create.top.equalToSuperview().offset(padding)
                create.bottom.equalToSuperview().offset(-padding)
                create.right.equalTo(guide)
                create.height.equalTo(self.height)
            }
        }
    }
}

extension UIView {
    func addDivider(color: UIColor, height: CGFloat,
                    padding: CGFloat, on position: AttachPosition) {
        let divider = Divider(to: self, color: color, height: height, padding: padding)
        divider.addDivider(on: position)
    }
}
