//
//  WalletIndicator.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import UIKit

class WalletIndicator: UIView {
    static let INDICATOR_HEIGHT: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
