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
    
    //MARK: RxSwift
    var disposeBag = DisposeBag()
    
    var viewDidLoadSubject = PublishSubject<T.Action>()
    var viewWillAppearSubject = PublishSubject<T.Action>()
    var viewWillDisappearSubject = PublishSubject<T.Action>()
    var viewDidDisappearSubject = PublishSubject<T.Action>()
    
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setConstraints()
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
}
