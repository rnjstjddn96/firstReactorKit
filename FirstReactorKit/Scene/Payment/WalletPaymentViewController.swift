//
//  WalletPayment.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/13.
//

import Foundation
import UIKit
import ReactorKit
import RxDataSources

class WalletPaymentViewController: BaseViewController<WalletPaymentReactor> {
    let paymentList = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .systemIndigo

        $0.register(Reusables.Cell.paymentCell)
        $0.register(Reusables.Cell.paymentLoadingCell)
    }
    
    override func setConstraints() {
        self.view.backgroundColor = .systemIndigo
        self.view.addSubview(paymentList)
        paymentList.snp.makeConstraints { create in
            create.left.right.equalToSuperview()
            create.top.bottom.equalToSuperview()
        }

        paymentList.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.on(.next(.getCards))
        viewWillAppearSubject.on(.next(.getCMAAccount))
    }
}

extension WalletPaymentViewController: View {
    typealias DataSource = RxTableViewSectionedReloadDataSource<PaymentSection>
    func bind(reactor: WalletPaymentReactor) {
        viewWillAppearSubject
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let configureCell: DataSource.ConfigureCell = { dataSource, tableView, indexPath, type in
            switch type {
            case .loadingCell:
                let cell = tableView.dequeue(Reusables.Cell.paymentLoadingCell, for: indexPath)
                return cell
            case .cardCell(let reactor):
                let cell = tableView.dequeue(Reusables.Cell.paymentCell, for: indexPath)
                cell.reactor = reactor
                return cell
            case .cmaCell:
                let cell = tableView.dequeue(Reusables.Cell.paymentLoadingCell, for: indexPath)
                return cell
            }
        }
        let datasource = DataSource(configureCell: configureCell)
        datasource.titleForHeaderInSection = { dataSource, index in
            return dataSource[index].header
        }
        
        reactor.state
            .map { $0.payments }
            .bind(to: paymentList.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

        paymentList.rx
            .modelSelected(PaymentCellSelection.self)
            .subscribe(onNext: { selection in
                switch selection {
                case .cardCell(let reactor):
                    log.debug(reactor.currentState.account)
                case .cmaCell:
                    log.debug("CMA Cell")
                case .loadingCell:
                    log.debug("Loading Cell")
                }
        })
        .disposed(by: disposeBag)
    }
}


extension WalletPaymentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
