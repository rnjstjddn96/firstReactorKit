//
//  PopupViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/18.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import PopupDialog
import RxGesture

class PopupViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    let btnPopup =
        UIButton.Builder()
        .withText("popup", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()
    
    let btnTf =
        UIButton.Builder()
        .withText("TfPopup", for: .normal)
        .withTextColor(.white, for: .normal)
        .withBackground(color: .black)
        .withCornerRadius(radius: 10)
        .build()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addView()
        buttonTap()
    }
    
    func addPopup() {
        //Dialog Default View Appearance Settings
        let dialogAppearance = PopupDialogDefaultView.appearance()

        dialogAppearance.backgroundColor      = .systemPink
        dialogAppearance.titleFont            = .boldSystemFont(ofSize: 14)
        dialogAppearance.titleColor           = UIColor(white: 0.4, alpha: 1)
        dialogAppearance.titleTextAlignment   = .center
        dialogAppearance.messageFont          = .systemFont(ofSize: 14)
        dialogAppearance.messageColor         = UIColor(white: 0.6, alpha: 1)
        dialogAppearance.messageTextAlignment = .center
        
        // Dialog Container Appearance Settings
        let containerAppearance = PopupDialogContainerView.appearance()

        containerAppearance.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        containerAppearance.cornerRadius    = 10
        containerAppearance.shadowEnabled   = true
        containerAppearance.shadowColor     = .black
        containerAppearance.shadowOpacity   = 0.6
        containerAppearance.shadowRadius    = 20
        containerAppearance.shadowOffset    = CGSize(width: 0, height: 8)

        // Overlay View Appearance Settings
        let overlayAppearance = PopupDialogOverlayView.appearance()

        overlayAppearance.color           = .yellow
        overlayAppearance.blurRadius      = 20
        overlayAppearance.blurEnabled     = true
        overlayAppearance.liveBlurEnabled = false
        overlayAppearance.opacity         = 0.7
        
        // Button Appearance Settings
        let defaultAppearance = DefaultButton.appearance()
        defaultAppearance.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        defaultAppearance.titleColor     = .red
        defaultAppearance.buttonColor    = .white
        defaultAppearance.separatorColor = UIColor(white: 0.9, alpha: 1)
        let cancelAppearance = CancelButton.appearance()
        cancelAppearance.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        cancelAppearance.titleColor     = .blue
        cancelAppearance.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        cancelAppearance.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)

        // Prepare the popup assets
        let title = "회원가입을 중지하시겠습니까?"
        let message = "중지 시 입력정보는 저장되지 않습니다."
        
        /*
         - PopupDialog -
         title: String?,
         message: String?,
         image: UIImage? = nil,
         buttonAlignment: UILayoutConstraintAxis = .vertical,
         transitionStyle: PopupDialogTransitionStyle = .bounceUp,
         preferredWidth: CGFloat = 340,
         tapGestureDismissal: Bool = true,
         panGestureDismissal: Bool = true,
         hideStatusBar: Bool = false,
         completion: (() -> Void)? = nil)
         */
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                preferredWidth: 580)

        // Create buttons
        let buttonOne = CancelButton(title: "취소") {
            print("취소 클릭")
        }

        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "확인", dismissOnTap: true) {
            print("확인 클릭")
        }
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
        popup.addButtons([buttonOne, buttonTwo])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    func addTf() {
        let tfVc = TextFeildPopupViewController()
        
        // Create the dialog
        let popup = PopupDialog(viewController: tfVc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 40) {
            print("취소 클릭")
        }

        // Create second button
        let buttonTwo = DefaultButton(title: "OK", height: 40) {
            print("OK 클릭")
            print(tfVc.tfText as Any)
        }

        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    func buttonTap() {
        btnPopup.rx.tap
            .bind {
                self.addPopup()
            }
            .disposed(by: disposeBag)
        
        btnTf.rx.tap
            .bind {
                self.addTf()
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
        
        view.addSubview(btnTf)
        
        btnTf.snp.makeConstraints { create in
            create.top.equalTo(btnPopup.snp.bottom).offset(30)
            create.centerX.equalToSuperview()
            create.width.equalTo(80)
            create.height.equalTo(50)
        }
    }
    
}


class TextFeildPopupViewController: UIViewController, UITextFieldDelegate {
    
    var disposeBag: DisposeBag = DisposeBag()
    var tfText: String?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "별칭 변경"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.addLeftPadding()
        return textField
    }()
    
    override func viewDidLoad() {
        view.addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(textField)
        textField.delegate = self
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
            $0.width.equalTo(300)
            $0.height.equalTo(182)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(10)
            $0.left.equalTo(containerView.snp.left)
            $0.right.equalTo(containerView.snp.right)
            $0.height.equalTo(20)
        }

        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.left.equalTo(containerView.snp.left).offset(10)
            $0.right.equalTo(containerView.snp.right).offset(-10)
            $0.height.equalTo(40)
        }
        
        textField.rx.text.orEmpty
            .map { $0.count < 1}
            .map { isTrue in
                if isTrue {
                    return "1글자 이하 입니다."
                } else {
                    return self.textField.text
                }
            }
            .subscribe(onNext: { result in
                self.tfText = result
            })
            .disposed(by: disposeBag)
        
        view.rx.tapGesture()
            .subscribe(onNext:{_ in
                self.endEditing()
            })
            .disposed(by: disposeBag)
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}
