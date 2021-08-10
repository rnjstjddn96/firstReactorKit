//
//  MenuRouteCell.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation
import UIKit
import SnapKit
import ReactorKit

enum MenuCellType {
    case ROUTE(_ title: String)
    case SWITCH(_ title: String)
}

class MenuRouteCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    //MARK: UI
    var title = UILabel
        .Builder()
        .withMaxLine(limit: 1)
        .withFont(.systemFont(ofSize: 20))
        .build()
    
    var arrow = UIButton
        .Builder()
        .withImage(image: "arrow.right".asImage)
        .withFont(.systemFont(ofSize: 20))
        .build()

    override func initialize() {
        self.addSubview(title)
        self.addSubview(arrow)
    }
    
    override func configureUI() {
        
    }
    
    override func setupConstraints() {
        title.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.left.equalToSuperview().offset(20)
        }
        
        arrow.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.right.equalToSuperview().offset(-30)
        }
    }
}

extension MenuRouteCell: View {
    func bind(reactor: MenuRouteCellReactor) {
        self.title.text = reactor.currentState.title
    }
}

class MenuSwitchCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    //MARK: UI
    var title = UILabel
        .Builder()
        .withMaxLine(limit: 1)
        .withFont(.systemFont(ofSize: 20))
        .build()

    let `switch` = UISwitch().then {
        $0.isOn = true
    }
    
    override func initialize() {
        self.addSubview(title)
        self.addSubview(`switch`)
    }
    
    override func configureUI() {
        
    }
    
    override func setupConstraints() {
        title.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.left.equalToSuperview().offset(20)
        }
        
        `switch`.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.right.equalToSuperview().offset(-30)
        }
    }
}

extension MenuSwitchCell: View {
    func bind(reactor: MenuSwitchCellRector) {
        reactor.state
            .map { $0.menu?.title ?? "" }
            .bind(to: self.title.rx.text)
            .disposed(by: disposeBag)
    }
}
