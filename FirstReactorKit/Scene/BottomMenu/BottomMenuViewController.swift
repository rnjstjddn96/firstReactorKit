//
//  BottomMenuViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa

enum BottomMenuState {
    case EXPANDED, CLOSED
    
    var amount: CGFloat {
        switch self {
        case .CLOSED:
            return BottomMenuIndicator.INDICATOR_HEIGHT
        case .EXPANDED:
            return UIScreen.main.bounds.size.height - 100
        }
    }
}

class BottomMenuIndicator: UIView {
    static let INDICATOR_HEIGHT: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BottomMenuViewController: UIViewController {
    
    let indicator = BottomMenuIndicator()
    var disposeBag = DisposeBag()
    
    //Reactor로 이동 필요
    let currentHeight: CGFloat = 100            //MainReactor로 부터 값 조정
    
    //improvement: RxGesture
    let tapGesture = UITapGestureRecognizer()
    let dragGesture = UIGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = currentHeight / 2
        
        self.view.addSubview(indicator)
        self.indicator.snp.makeConstraints { create in
            create.top.left.right.equalToSuperview()
            create.height.equalTo(100)
        }
    }
    
}
