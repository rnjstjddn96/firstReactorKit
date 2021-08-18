//
//  BottomPopupViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/18.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture

class BottomViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    let btnPopup =
        UIButton.Builder()
        .withText("popup", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        buttonTap()
    }
    
    func buttonTap() {
        btnPopup.rx.tap
            .bind {
                let bdVC = BottomDetailViewController()
                bdVC.height = 300
                bdVC.dismissDuration = 0.5
                bdVC.presentDuration = 0.5
                bdVC.shouldDismissInteractivelty = true
                bdVC.dimmingViewAlpha = 0.5
                self.present(bdVC, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    func addView() {
        view.addSubview(btnPopup)
        
        btnPopup.snp.makeConstraints { create in
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
    }

}

