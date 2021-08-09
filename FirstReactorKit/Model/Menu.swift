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
    
    init(title: String) {
        self.title = title
    }
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

