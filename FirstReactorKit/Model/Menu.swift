//
//  Menu.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation
import UIKit
import RxDataSources
import ReactorKit

struct Menu {
    var title: String
    var destination: UIViewController? = nil
    
    init(title: String, destination: UIViewController? = nil) {
        self.title = title
        self.destination = destination
    }
}

enum MenuCellSelection {
    case routeCell(MenuRouteCellReactor)
    case switchCell(MenuSwitchCellRector)
}

struct MenuSectionData {
    var header: String
    var items: [MenuCellSelection]
}

extension MenuSectionData: SectionModelType {
    typealias Item = MenuCellSelection
    
    init(original: MenuSectionData, items: [MenuCellSelection]) {
        self = original
        self.items = items
    }
}

