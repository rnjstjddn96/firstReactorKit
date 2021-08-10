//
//  SplashLogoView.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit
import SnapKit

class SplashLogoView: UIView {
    let splashSize: CGFloat = SIZE.width * 0.7
    
    let splashLogo =
        UILabel.Builder()
        .withText("Splash Logo")
        .withFont(.systemFont(ofSize: 30, weight: .bold))
        .withTextAlignment(.center)
        .withTextColor(.black)
        .withAlpha(alpha: 0.0)
        .build()
    
    func initSplashLogo(to view: UIView) {
        view.addSubview(self)
        self.addSubview(splashLogo)
        self.snp.makeConstraints { create in
            create.center.equalToSuperview()
            create.width.height.equalToSuperview()
        }
        splashLogo.snp.makeConstraints { create in
            create.center.equalToSuperview()
            create.width.height.equalTo(splashSize)
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.splashLogo.alpha = 1.0
        }
    }
    
    func deinitSplashLogo() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.splashLogo.alpha = 0.0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.splashLogo.removeFromSuperview()
        }
    }
}
