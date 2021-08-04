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

class BottomMenuViewController: UIViewController {

    let indicator = BottomMenuIndicator()
    var disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 50
        
        self.view.addSubview(indicator)
        self.indicator.snp.makeConstraints { create in
            create.top.left.right.equalToSuperview()
            create.height.equalTo(100)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { create in
            create.top.equalTo(indicator.snp.bottom)
            create.left.right.bottom.equalToSuperview()
        }
        
        setTableView()
    }
    
    private func setTableView() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.ID)
    }
}

extension BottomMenuViewController: View {
    func bind(reactor: BottomMenuReactor) {
        
    }
}

class BottomMenuReactor: Reactor, APIService {
    var session: NetworkService = NetworkService()
    var initialState: State = State()
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var todos: [Todo] = []
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return Observable.create { observer in
            return Disposables.create()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        return newState
    }
}
