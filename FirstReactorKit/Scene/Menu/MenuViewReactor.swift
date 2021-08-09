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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var sections: [MenuSectionModel]
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
                    
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
                
        switch mutation {
            
        }
        return newState
    }
    
    static func configMenus() -> [MenuSectionModel] {
        var sections: [MenuSectionModel] = []
        
        let displayData1: [[MenuCellType]] = [
            [.ROUTE("1"), .SWITCH("2"), .SWITCH("2"), .ROUTE("4")]
        ]
        
        let displayData2: [[MenuCellType]] = [
            [.ROUTE("1"), .ROUTE("2"), .SWITCH("2"), .ROUTE("4")]
        ]
        
        for cellSection in displayData1 {
            var section: [MenuCellSelection] = []
            for item in cellSection {
                switch item {
                case .ROUTE(let title):
                    let item: MenuCellSelection
                        = .routeCell(MenuRouteCellReactor(state: Menu(title: title)))
                    section.append(item)
                case .SWITCH(let title):
                    let item: MenuCellSelection
                        = .switchCell(MenuSwitchCellRector(state: Menu(title: title)))
                    section.append(item)
                }
            }
            sections.append(MenuSectionModel(header: "section1", items: section))
        }
        
        for cellSection in displayData2 {
            var section: [MenuCellSelection] = []
            for item in cellSection {
                switch item {
                case .ROUTE(let title):
                    let item: MenuCellSelection
                        = .routeCell(MenuRouteCellReactor(state: Menu(title: title)))
                    section.append(item)
                case .SWITCH(let title):
                    let item: MenuCellSelection
                        = .switchCell(MenuSwitchCellRector(state: Menu(title: title)))
                    section.append(item)
                }
            }
            sections.append(MenuSectionModel(header: "section2", items: section))
        }
        
        return sections
    }
}
