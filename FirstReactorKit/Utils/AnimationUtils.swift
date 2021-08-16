//
//  AnimationUtils.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/08.
//

import Foundation
import UIKit

final class AnimationUtils {
    
}

extension UIView {
    func animate(duration: TimeInterval,
                 animations: @escaping (() -> Void),
                 completion: ((_ finished: Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: {
                        animations()
                        self.layoutIfNeeded()
                       },
                       completion: completion)
    }
    
    func animateWithSpring(duration: TimeInterval,
                           delay: TimeInterval = 0,
                           damping: CGFloat,
                           initialVelocity: CGFloat,
                           animationOptions: UIView.AnimationOptions = [],
                           animations: @escaping (() -> Void),
                           completion: ((_ finished: Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: initialVelocity,
                       options: animationOptions,
                       animations: {
                        animations()
                        self.layoutIfNeeded()
                       },
                       completion: completion)
    }
    
    func addSubview(subView: UIView,
                    duration: Double,
                    type: CATransitionType,
                    subtype: CATransitionSubtype) {
        let transition = CATransition()
        transition.type = type
        transition.subtype = subtype
        transition.duration = duration
        self.layer.add(transition, forKey: nil)
        self.addSubview(subView)
    }
    
    func removeFromSuperview(duration: Double,
                             type: CATransitionType,
                             subtype: CATransitionSubtype) {
        let t = CATransition()
        t.type = CATransitionType.push
        t.subtype = .fromRight
        t.duration = duration
        self.layer.add(t, forKey: nil)
        self.removeFromSuperview()
    }
}
