//
//  ToastMessage.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/18.
//

import Foundation
import UIKit
import SnapKit

class ToastMessage {
    public static let shared = ToastMessage()
    func show(message: String) {
        if let window = UIApplication.shared.windows.first {
            let labelFrameImg = UIImage(named: "alarmBottmTextRectangle")
            let imgView = UIImageView(frame: CGRect(x: 70, y: 50, width: window.bounds.width - 140, height: 40))
            imgView.image = labelFrameImg
            let label = UILabel(frame: CGRect(x: 70, y: 50, width: window.bounds.width - 140, height: 40))
            label.text = message
            label.textColor = .black
            label.textAlignment = .center
            window.addSubview(imgView)
            window.addSubview(label)
            imgView.alpha = 0
            label.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                imgView.alpha = 1
                label.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    imgView.alpha = 0
                    label.alpha = 0
                }, completion: { _ in
                    imgView.removeFromSuperview()
                    label.removeFromSuperview()
                })
            })
        }
    }
}
