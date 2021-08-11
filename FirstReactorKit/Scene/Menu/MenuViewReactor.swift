//
//  MenuViewReactor.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation
import ReactorKit

class MenuViewReactor: Reactor {
    let initialState: State
    
    init() {
        self.initialState = State(
            sections: MenuViewReactor.configMenus()
        )
    }
    
    enum Action {
        case route(to: UIViewController)
    }
    
    enum Mutation {
        case setDestination(view: UIViewController)
    }
    
    struct State {
        var sections: [MenuSectionData]
        var destination: UIViewController?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .route(to: let vc):
            return Observable.just(Mutation.setDestination(view: vc))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setDestination(view: let vc):
            newState.destination = vc
        }
        return newState
    }
    
    static func configMenus() -> [MenuSectionData] {
        var sections: [MenuSectionData] = []
        let destination: UIViewController = SampleDetailViewController()
        
        let displayData1: [[MenuCellType]] = [
            [.ROUTE("메뉴1", destination), .SWITCH("토글1"), .SWITCH("메뉴2"), .ROUTE("메뉴3", destination)]
        ]
        
        let displayData2: [[MenuCellType]] = [
            [.ROUTE("메뉴4", destination), .SWITCH("토글2"), .SWITCH("토글3"), .ROUTE("메뉴5", destination)]
        ]
        
        for cellSection in displayData1 {
            var section: [MenuCellSelection] = []
            for item in cellSection {
                switch item {
                case .ROUTE(let title, let destination):
                    let item: MenuCellSelection
                        = .routeCell(MenuRouteCellReactor(menu: Menu(title: title, destination: destination)))
                    section.append(item)
                case .SWITCH(let title):
                    let item: MenuCellSelection
                        = .switchCell(MenuSwitchCellRector(menu: Menu(title: title)))
                    section.append(item)
                }
            }
            sections.append(MenuSectionData(header: "section1", items: section))
        }
        
        for cellSection in displayData2 {
            var section: [MenuCellSelection] = []
            for item in cellSection {
                switch item {
                case .ROUTE(let title, let destination):
                    let item: MenuCellSelection
                        = .routeCell(MenuRouteCellReactor(menu: Menu(title: title, destination: destination)))
                    section.append(item)
                case .SWITCH(let title):
                    let item: MenuCellSelection
                        = .switchCell(MenuSwitchCellRector(menu: Menu(title: title)))
                    section.append(item)
                }
            }
            sections.append(MenuSectionData(header: "section2", items: section))
        }
        
        return sections
    }
}
