//
//  BottomDetailViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/18.
//

import UIKit
import BottomPopup
import SnapKit
import RxCocoa
import RxSwift
import RxGesture

class BottomDetailViewController: BottomPopupViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    let imgView: UIImageView = {
        let imgview = UIImageView(image: UIImage(named: "darkOnLight"))
        return imgview
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 30
        return view
    }()
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var dimmingViewAlpha: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imgView)
        view.addSubview(containerView)
        
        imgView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-30)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        imgView.rx.tapGesture()
            .bind(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
    }
    
    override var popupHeight: CGFloat { return height ?? CGFloat(500) }
        
    override var popupTopCornerRadius: CGFloat { return topCornerRadius ?? CGFloat(0) }
    
    override var popupPresentDuration: Double { return presentDuration ?? 1.0 }
    
    override var popupDismissDuration: Double { return dismissDuration ?? 1.0 }
    
    override var popupShouldDismissInteractivelty: Bool { return shouldDismissInteractivelty ?? true }
    
    override var popupDimmingViewAlpha: CGFloat { return dimmingViewAlpha ?? 0.1 }

}
