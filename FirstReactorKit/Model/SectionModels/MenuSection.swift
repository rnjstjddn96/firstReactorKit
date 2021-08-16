//
//  MenuSection.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import RxDataSources

enum MenuCellSelection {
    case routeCell(MenuRouteCellReactor)
    case switchCell(MenuSwitchCellRector)
}

struct MenuSection {
    var header: String
    var items: [MenuCellSelection]
}

extension MenuSection: SectionModelType {
    typealias Item = MenuCellSelection
    
    init(original: MenuSection, items: [MenuCellSelection]) {
        self = original
        self.items = items
    }
}

