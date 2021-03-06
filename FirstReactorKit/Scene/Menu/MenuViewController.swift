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

class MenuViewController: BaseViewController<MenuViewReactor> {
    var navigationBar = NavigationBar(frame: .zero,
                                      title: "메뉴",
                                      leftType: .back,
                                      rightType: nil)

    let menuListView = UITableView().then {
        $0.register(Reusables.Cell.menuRouteCell)
        $0.register(Reusables.Cell.menuSwitchCell)
        
        $0.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        
        navigationBar.leftButton!.rx
            .controlEvent(.touchUpInside)
            .bind {
                self.dismiss(type: .POP(type: .COUNTABLE(count: 1)))
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
    typealias DataSource = RxTableViewSectionedReloadDataSource<MenuSection>
    func bind(reactor: MenuViewReactor) {
        menuListView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        let dataSource = DataSource { dataSource, tableView, indexPath, sectionItems in
            switch sectionItems {
            case .routeCell(let reactor):
                guard let cell = tableView.dequeue(Reusables.Cell.menuRouteCell) else {
                    return UITableViewCell()
                }
                cell.withSelectionStyle(style: .none)
                cell.reactor = reactor
                return cell
            case .switchCell(let reactor):
                guard let cell = tableView.dequeue(Reusables.Cell.menuSwitchCell) else {
                    return UITableViewCell()
                }
                cell.withSelectionStyle(style: .none)
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
        
        menuListView.rx
            .modelSelected(MenuCellSelection.self)
            .map { cell in
                switch cell {
                case .routeCell(let _reactor):
                    let destination = _reactor.currentState.menu?.destination
                    return Reactor.Action.route(to: destination!)
                case .switchCell:
                    return Reactor.Action.route(to: SampleDetailViewController1() )
                }
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.destination }
            .asObservable()
            .filter { $0 != nil }
            .bind { [weak self] destination in
                guard let self = self else { return }
                self.route(to: destination!, navigateType: .PUSH)
            }
            .disposed(by: disposeBag)
    }
}

extension MenuViewController: UITableViewDelegate {
    
}
