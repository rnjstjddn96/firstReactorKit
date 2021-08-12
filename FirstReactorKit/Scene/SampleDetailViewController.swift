//
//  SampleDetailViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/11.
//

import Foundation
import UIKit
import RxSwift
import ReactorKit
import RxDataSources

class SampleDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemIndigo
    }
}

class SampleDetailViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
    }
}

struct SectionOfCustomData {
    var header: String? = nil
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = Todo
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

class SampleDetailTableViewController: BaseViewController<SampleTableViewReactor> {
    let tableView = UITableView().then {
//        $0.register(Reusables.Cell.customCell)
        $0.register(CustomCell.self, forCellReuseIdentifier: CustomCell.ID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { create in
            create.left.right.equalToSuperview()
            create.top.bottom.equalToSuperview()
        }

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.on(.next(.getTodos))
    }
}

extension SampleDetailTableViewController: View {
    
    func bind(reactor: Reactor) {
        viewWillAppearSubject
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Void, Todo>>(configureCell: { dataSource, tableView, row, item in
            guard let cell = tableView.dequeue(Reusables.Cell.customCell) else { return UITableViewCell() }
            cell.bindUI(text: item.title ?? "",
                        image: UIImage(named: "profile")!)
            return cell
        })
        
//        dataSource.titleForHeaderInSection = { dataSource, index in
//            return dataSource[index].header
//        }
        
//        reactor.state
//            .map { $0.todos }
//            .asObservable()
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.todos }
            .bind(to: tableView.rx.items(cellIdentifier: CustomCell.ID,
                                         cellType: CustomCell.self)) { row, todo, cell in
                cell.bindUI(text: todo.title ?? "",
                           image: UIImage(named: "profile")!)
            }
            .disposed(by: disposeBag)
        
//        tableView.rx
//            .modelSelected(Todo.self)
//            .subscribe(onNext: { element in
//            log.debug(element)
//        })
//        .disposed(by: disposeBag)
    }
}

extension SampleDetailTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class SampleTableViewReactor: Reactor, APIService {
    var session: NetworkService = NetworkService()
    var initialState: State = State()
    
    enum Action {
        case getTodos
//        case showIndicator
//        case hideIndicator
//        case showError(error: ReactorError)
    }
    
    enum Mutation {
        case setTodos(todos: [Todo])
        case setIndicator(isOn: Bool)
        case setError(error: ReactorError)
    }
    
    struct State {
        var todos: [Todo] = []
        var isLoading: Bool = false
        var error: ReactorError?
    }
    
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        let refreshTodos = WalletManager.shared.eventRelay
            .asObservable()
            .distinctUntilChanged()
            //Refresh data after menu closed
//            .filter { $0 == .closeMenu }
            .flatMapLatest { event -> Observable<Action> in
                return .just(Action.getTodos)
            }
            .observe(on: MainScheduler.asyncInstance)

        return Observable.merge(action, refreshTodos)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        var getTodos: Observable<Mutation> {
            return Observable.concat([
                Observable.just(Mutation.setIndicator(isOn: true)),
                self.getTodos()
                    .map { result in
                        if let todos = result.value {
                            return Mutation.setTodos(todos: todos)
                        } else {
                            return .setError(error: .NETWORK(failure: result.failed,
                                                             error: result.error))
                        }
                    },
                Observable.just(Mutation.setIndicator(isOn: false))
            ])
        }
        
        switch action {
        case .getTodos:
            return getTodos
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState: State = state
        switch mutation {
        case .setError(error: let error):
            newState.error = error
        case .setIndicator(isOn: let isOn):
            newState.isLoading = isOn
        case .setTodos(todos: let todos):
            newState.todos = todos
        }
        return newState
    }
}
