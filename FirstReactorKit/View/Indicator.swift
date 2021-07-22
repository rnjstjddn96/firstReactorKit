//
//  Indicator.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit
import Lottie

class LoadingIndicator: NSObject {
    var view:UIView!
    var title:String?
    var progress:AnimationView!
    let progressSize: CGFloat = SIZE.width * 0.4
    
    init(view:UIView) {
        
        self.view = view
        super.init()
        self.addProgressView()
        
    }
    
    init(view:UIView, title:String){
        
        self.view = view
        self.title = title
        super.init()
        self.addProgressView()
        
    }
    
    private func addProgressView() {
        self.progress = AnimationView(name: "loader")
        self.progress.frame = CGRect(x: 0, y: 0, width: progressSize, height: progressSize)
        self.progress.center = CGPoint(x: SIZE.width / 2, y: SIZE.height / 2)
        self.progress.contentMode = .scaleAspectFill
        self.view.addSubview(self.progress)
        self.progress.alpha = 0.0
    }
    
    func showIndicator(on: Bool) {
        if on {
            self.progress.loopMode = LottieLoopMode.loop
            self.progress.animationSpeed = 2.0
            self.progress.play()
            UIView.animate(withDuration: 0.3, animations: {
                self.progress.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.progress.alpha = 0.0
            }) { (_) in
                self.progress.stop()
            }
        }
    }
}

