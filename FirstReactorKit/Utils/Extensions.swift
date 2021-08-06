//
//  Extension.swift
//  Swift_Test
//
//  Created by imform-mm-2103 on 2021/07/06.
//

import Foundation
import UIKit

enum SizeFactor {
    case WIDTH, HEIGHT
    
    var size: CGFloat {
        switch self {
        case .WIDTH:
            return SIZE.width
        case .HEIGHT:
            return SIZE.height
        }
    }
}

extension Double {
    func asPercent(with sizeFactor: SizeFactor) -> CGFloat {
        return CGFloat(Double(sizeFactor.size) * (self / 100))
    }
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
