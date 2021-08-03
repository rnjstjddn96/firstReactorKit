//
//  ViewRouter.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit

final class ViewRouter {
    class func route<T: UIViewController>(
        from source: UIViewController,
        to destination: T?,
        withNavigation: Bool = false,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        completion: (() -> Void)? = nil) {
        
        guard let _destination = destination else { return }
        if withNavigation {
            source.navigationController?.pushViewController(_destination, animated: true)
        } else {
            _destination.modalTransitionStyle = transitionStyle
            _destination.modalPresentationStyle = presentationStyle
            source.present(_destination, animated: true, completion: {
                guard let _completion = completion else { return }
                _completion()
            })
        }
    }
}
