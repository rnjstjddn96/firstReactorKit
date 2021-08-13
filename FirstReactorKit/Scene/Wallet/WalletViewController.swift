//
//  WalletViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa
import Parchment

class WalletViewController: BaseViewController<WalletReactor> {
    
    var pagingViewController: PagingViewController? = nil
    let indicator = WalletIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSubject.onNext(.loadMenu(menus: WalletMenu.allCases))
    }
    
    override func setConstraints() {
        self.view.layer.masksToBounds = true
        self.view.roundCorners(corners: [.topLeft, .topRight],
                               radius: WalletIndicator.INDICATOR_HEIGHT / 2)
        self.view.addSubview(indicator)
        self.indicator.snp.makeConstraints { create in
            create.top.left.right.equalToSuperview()
            create.height.equalTo(WalletIndicator.INDICATOR_HEIGHT)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.on(.completed)
    }
    
    private func addTabBar(tabs: [TabBarInterface]) {
        pagingViewController = PagingViewController(
            viewControllers: tabs.map { $0.destination }
        )
        if let pvc = pagingViewController {
            pvc.delegate = self
            pvc.dataSource = self
            pvc.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            pvc.selectedFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            pvc.textColor = .systemGray3
            pvc.selectedTextColor = .label
            pvc.indicatorColor = .red
            pvc.menuItemSize = .selfSizing(estimatedWidth: 55,
                                           height: SIZE.width * 0.112)
            pvc.menuItemLabelSpacing = 0
            pvc.menuInsets = UIEdgeInsets(top: 0, left: 0.05 * SIZE.width,
                                          bottom: .zero, right: 0.05 * SIZE.width)
            pvc.menuItemSpacing = 30
            pvc.indicatorOptions = .visible(height: 4, zIndex: Int.max, spacing: .zero, insets: .zero)
            
            self.addChild(pvc)
            self.view.addSubview(pvc.view)
            pvc.didMove(toParent: self)
            
            pvc.view.snp.makeConstraints { create in
                create.top.equalTo(indicator.snp.bottom)
                create.left.right.bottom.equalToSuperview()
            }
        }
    }
}

extension WalletViewController: PagingViewControllerDelegate, PagingViewControllerDataSource {
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: reactor!.currentState.menus[index].title)
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return self.reactor!.currentState.menus[index].destination
    }
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return self.reactor!.currentState.menus.count
    }
}

extension WalletViewController: View {
    func bind(reactor: WalletReactor) {
        let manager = WalletManager.shared
        
        viewDidLoadSubject
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        viewWillAppearSubject
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.indicator.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { _ in
                switch manager.currentState.value {
                case .CLOSED:
                    _ = manager.updateState(event: .openMenu)
                case .EXPANDED:
                    _ = manager.updateState(event: .closeMenu)
                }
            })
            .disposed(by: disposeBag)
        
        self.indicator.rx
            .swipeGesture(.up)
            .when(.ended)
            .bind(onNext: { swipe in
                _ = manager.updateState(event: .openMenu)
            })
            .disposed(by: disposeBag)
        
        self.indicator.rx
            .swipeGesture(.down)
            .when(.ended)
            .bind(onNext: { swipe in
                _ = manager.updateState(event: .closeMenu)
            })
            .disposed(by: disposeBag)
        
        viewWillAppearSubject
            .asObservable()
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.menus }
            .bind { [weak self] tabs in
                guard let self = self else { return }
                self.addTabBar(tabs: tabs)
            }
            .disposed(by: disposeBag)
    }
}
