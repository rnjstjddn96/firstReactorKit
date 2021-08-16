//
//  BaseViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/10.
//

import Foundation
import UIKit
import ReactorKit
import Then
import SnapKit

class BaseViewController<T: Reactor>: UIViewController {
    typealias Reactor = T
    
    //MARK: RxSwift
    var disposeBag = DisposeBag()
    
    var viewEventSubject = PublishSubject<T.Action>()
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            self.updateConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func updateConstraints() {
        
    }
    
    func setConstraints() {
        
    }
    
}

extension BaseViewController {
    func showBasicAlert(title: String?,
                        message: String,
                        showCancelButton: Bool,
                        okButtonTitle: String,
                        cancelButtonTitle: String?,
                        okButtonCallback: (() -> Void)?,
                        cancelButtonCallback: (() -> Void)?) {
        
        AlertUtils.displayBasicAlert(controller: self, title: title,
                                     message: message,
                                     showCancelButton: showCancelButton,
                                     okButtonTitle: okButtonTitle,
                                     cancelButtonTitle: cancelButtonTitle,
                                     okButtonCallback: okButtonCallback,
                                     cancelButtonCallback: cancelButtonCallback)
    }
    
    func route<T: UIViewController>(to destination: T?,
                                    navigateType: NavigateType.Route,
                                    presentationStyle: UIModalPresentationStyle = .fullScreen,
                                    transitionStyle: UIModalTransitionStyle = .coverVertical,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        
        ViewRouter.route(from: self,
                         to: destination,
                         navigateType: navigateType,
                         presentationStyle: presentationStyle,
                         transitionStyle: transitionStyle,
                         animated: animated,
                         completion: completion)
    }
}

extension Reactor {
    typealias PresentationStyle = (presentationStyle: UIModalPresentationStyle,
                                   transitionStyle: UIModalTransitionStyle)
}
