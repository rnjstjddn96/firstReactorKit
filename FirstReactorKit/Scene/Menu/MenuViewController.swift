//
//  TableViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa
import ReusableKit
import RxDataSources
import Then

enum MenuCellSelection {
    case routeCell(MenuRouteCellReactor)
    case switchCell(MenuSwitchCellRector)
}

class MenuViewController: BaseViewController<MenuViewReactor> {
    lazy var navigationBar = NavigationBar()
    
    let menuListView = UITableView().then {
        $0.register(Reusables.Cell.menuRouteCell)
        $0.register(Reusables.Cell.menuSwitchCell)
        
        $0.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        
        navigationBar.btnBack.rx
            .controlEvent(.touchUpInside)
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(menuListView)
        navigationBar.snp.makeConstraints { create in
            create.left.right.equalToSuperview()
            create.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            create.height.equalTo(70)
        }
        
        menuListView.snp.makeConstraints { create in
            create.left.right.bottom.equalToSuperview()
            create.top.equalTo(navigationBar.snp.bottom)
        }
    }
}

extension MenuViewController: View {
    func bind(reactor: MenuViewReactor) {
        menuListView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MenuSectionData> { [weak self] dataSource, tableView, indexPath, sectionItems in
            guard let self = self else { return UITableViewCell() }
            switch sectionItems {
            case .routeCell(let reactor):
                guard let cell = self.menuListView.dequeue(Reusables.Cell.menuRouteCell) else {
                    return UITableViewCell()
                }
                cell.reactor = reactor
                return cell
            case .switchCell(let reactor):
                guard let cell = self.menuListView.dequeue(Reusables.Cell.menuSwitchCell) else {
                    return UITableViewCell()
                }
                cell.reactor = reactor
                return cell
            }
        }
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        reactor.state
            .map { $0.sections }
            .asObservable()
            .bind(to: menuListView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
//        menuListView.rx
//            .modelSelected(MenuCellSelection.self)
//            .map { cell in
//                switch cell {
//                case .routeCell(let reactor):
//                    return Reactor.Action.Type
//                case .switchCell(let reactor):
//                    return Reactor.Action.Type
//                }
//            }
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
    }
}

extension MenuViewController: UITableViewDelegate {
    
}
