//
//  WalletMenu.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/12.
//

import Foundation
import UIKit
import ReactorKit

protocol TabBarInterface {
    var title: String { get }
    var index: Int { get }
    var destination: UIViewController { get }
}

enum WalletMenu: CaseIterable, TabBarInterface {
    case PAYMENT
    case COUPON
    case HISTORY

    var index: Int {
        switch self {
        case .PAYMENT: return 0
        case .COUPON: return 2
        case .HISTORY: return 3
        }
    }
    
    var title: String {
        switch self {
        case .PAYMENT:
            return Strings.Wallet.Menu.PAYMENT
        case .COUPON:
            return Strings.Wallet.Menu.COUPON
        case .HISTORY:
            return Strings.Wallet.Menu.HISTORY
        }
    }

    var destination: UIViewController {
        switch self {
        case .PAYMENT:
            let destination = WalletPaymentViewController()
            destination.reactor = WalletPaymentReactor()
            return destination
        case .COUPON:
            let view = SampleDetailViewController()
            return view
        case .HISTORY:
            return SampleDetailViewController()
        }
    }
}
