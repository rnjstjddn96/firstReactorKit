//
//  ViewRouter.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit

enum NavigateType {
    enum Route {
        case PUSH
        case PRESENT
    }
    
    case POP(type: ViewsToPop)
    case DISMISS
}

enum ViewsToPop {
    case COUNTABLE(count: Int)
    case ROOT
}

final class ViewRouter {
    class func route<T: UIViewController>(
        from source: UIViewController,
        to destination: T?,
        navigateType: NavigateType.Route,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: (() -> Void)? = nil) {
        
        guard let _destination = destination else { return }
        switch navigateType {
        case .PRESENT:
            _destination.modalTransitionStyle = transitionStyle
            _destination.modalPresentationStyle = presentationStyle
            source.present(_destination, animated: true, completion: {
                guard let _completion = completion else { return }
                _completion()
            })
        case .PUSH:
            source.navigationController?.pushViewController(_destination, animated: true)
        }
    }
}

extension UIViewController {
    func dismiss(type: NavigateType, animated: Bool = true, then completion: @escaping (() -> Void)) {
        switch type {
        case .DISMISS:
            self.dismiss(animated: animated, completion: completion)
        case .POP(let type):
            switch type {
            case .COUNTABLE(let count):
                self.navigationController?.popViewControllers(viewsToPop: count)
            case .ROOT:
                self.navigationController?.popToRootViewController(animated: animated)
            }
        }
    }
 }

extension UINavigationController {

  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }

  func popViewControllers(viewsToPop: Int, animated: Bool = true) {
    if viewControllers.count > viewsToPop {
      let vc = viewControllers[viewControllers.count - viewsToPop - 1]
      popToViewController(vc, animated: animated)
    }
  }
    
    func popTopViewControllers(animated: Bool = true) {
        let vc = viewControllers[viewControllers.count - 1]
        popToViewController(vc, animated: animated)
    }
}
