//
//  WalletPaymentReactor.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/13.
//

import Foundation
import UIKit
import ReactorKit

class WalletPaymentReactor: Reactor, APIService {
    var session = NetworkService()
    var initialState: State = State()
    
    enum Action {
        case getCards
        case getCMAAccount
    }
    
    enum Mutation {
        case setPayments(payments: [Payment])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var payments: [PaymentSection] = [.init(header: nil, items: [.loadingCell])]
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    var getCards: Observable<Mutation> {
        return Observable.concat([
            Observable.just(Mutation.setIndicator(isOn: true)),
            self.getCards()
                .map { result in
                    if let cards = result.value {
                        let payments = cards.map { Payment.card($0) }
                        return Mutation.setPayments(payments: payments)
                    } else {
                        return .setError(error: .NETWORK(failure: result.failed,
                                                         error: result.error))
                    }
                },
            Observable.just(Mutation.setIndicator(isOn: false))
        ])
    }
    
    var getCMAAccounts: Observable<Mutation> {
        return Observable.concat([
            Observable.just(Mutation.setIndicator(isOn: true)),
            Observable.just(Mutation.setPayments(payments: [.cma, .cma])),
            Observable.just(Mutation.setIndicator(isOn: false))
        ])
    }
    
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        return Observable.merge(
            action,
            WalletManager.shared.eventRelay
                .filter{ $0.state == .CLOSED }
                .map { _ in Action.getCards },
            WalletManager.shared.eventRelay
                .filter{ $0.state == .CLOSED }
                .map { _ in Action.getCMAAccount }
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getCards:
            return getCards
                .delay(.seconds(3), scheduler: MainScheduler.instance)
        case .getCMAAccount:
            return getCMAAccounts
                .delay(.seconds(5), scheduler: MainScheduler.instance)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPayments(let payments):
            newState.payments = separatedPayment(currentSection: state.payments,
                                                 payments: payments)
        case .setError(error: let error):
            newState.error = error
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        }
        return newState
    }
}

extension WalletPaymentReactor {
    private func separatedPayment(currentSection: [PaymentSection], payments: [Payment]) -> [PaymentSection] {
        var currentSections = currentSection
        var selections: [PaymentCellSelection] = []
        var headerTitle: String = ""
        
        payments.forEach { payment in
            switch payment {
            case .card(let account):
                selections.append(.cardCell(CardCellReactor(account: account)))
                headerTitle = "카드"
            case .cma:
                selections.append(.cmaCell)
                headerTitle = "CMA 계좌"
            }
        }
        let resultSection = PaymentSection(header: headerTitle, items: selections)
        
        if !currentSections.contains(resultSection) {
            currentSections.append(resultSection)
        }
        
        return currentSections
            .filter { $0.header != nil } //loadingCell 제거
    }
}
