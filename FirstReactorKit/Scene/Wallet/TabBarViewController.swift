//
//  TabBarView.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/12.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

enum TabBarPosition {
    case TOP(topGuide: ConstraintItem)
    case BOTTOM(bottomGuide: ConstraintItem)
}
class TabBarView: UIView {
    var disposeBag = DisposeBag()
    
    let tabBarIndicator = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.tintColor = .systemIndigo
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTabBar<T>(position: TabBarPosition,
                       to parent: UIViewController,
                       dataSource: [T]) where T: TabBarControlInterface {
        let tabBarControl = UISegmentedControl(
            items: dataSource.map { $0.title }).then {
            $0.backgroundColor = .clear
            $0.tintColor = .clear
            $0.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!,
                                       NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
            $0.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 24)!,
                                       NSAttributedString.Key.foregroundColor: UIColor.systemIndigo], for: .selected)
        }
        
        parent.view.addSubview(self)
        self.addSubview(tabBarControl)
        self.addSubview(tabBarIndicator)

        setConstraints(position: position, tabBarControl: tabBarControl, parent: parent)
//        
//        tabBarControl.rx
//            .selectedSegmentIndex
//            .asObservable()
//            .bind { index in
//                log.debug("index: \(index)")
//            }
//            .disposed(by: disposeBag)
    }
    
    func setConstraints(position: TabBarPosition,
                        tabBarControl: UISegmentedControl,
                        parent: UIViewController) {
        
        switch position {
        case .BOTTOM(bottomGuide: let bottomGuide):
            self.snp.makeConstraints { create in
                create.left.right.equalToSuperview()
                create.bottom.equalTo(bottomGuide)
                create.height.equalTo(80)
            }
        case .TOP(topGuide: let topGuide):
            self.snp.makeConstraints { create in
                create.left.right.equalToSuperview()
                create.top.equalTo(topGuide)
                create.height.equalTo(80)
            }
        }
        
        tabBarControl.snp.makeConstraints { create in
            create.top.left.right.equalToSuperview()
            create.height.equalToSuperview()
        }
        
        tabBarIndicator.snp.makeConstraints { create in
            create.top.equalTo(tabBarControl.snp.bottom).offset(3)
            create.height.equalTo(2)
            create.width.equalTo(15 + tabBarControl.titleForSegment(at: 0)!.count * 8)
            create.centerX.equalTo(tabBarControl.snp.centerX)
                .dividedBy(tabBarControl.numberOfSegments)
        }
    }
    
//    func animateIndicator() {
//        let numberOfSegments = CGFloat(tabBarControl.numberOfSegments)
//        let selectedSegmentIndex = CGFloat(tabBarControl.selectedSegmentIndex)
//        let titleCount = CGFloat(tabBarControl.titleForSegment(at: tabBarControl.selectedSegmentIndex)!.count)
//        
//        tabBarIndicator.snp.remakeConstraints { remake in
//            remake.top.equalTo(tabBarControl.snp.bottom).offset(3)
//            remake.height.equalTo(2)
//            remake.width.equalTo(15 + (titleCount * 8))
//            remake.centerX.equalTo(tabBarControl.snp.centerX)
//                .dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedSegmentIndex - 1.0) * 2.0))
//        }
//        
//        self.animate(duration: 0.5) { [weak self] in
//            guard let self = self else { return }
//            self.tabBarIndicator.transform = CGAffineTransform(scaleX: 1.4, y: 1)
//        } completion: { [weak self] finish in
//            guard let self = self else { return }
//            self.tabBarIndicator.transform = CGAffineTransform.identity
//        }
//
//    }
}
