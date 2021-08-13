//
//  PaymentSectionData.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/13.
//

import Foundation
import UIKit
import ReactorKit
import RxDataSources

enum Payment {
    case card(CardAccountInfo)
    case cma
}

struct PaymentSection {
    var header: String?
    var items: [PaymentCellSelection]
}

enum PaymentCellSelection {
    case loadingCell
    case cardCell(CardCellReactor)
    case cmaCell
}

extension PaymentSection: SectionModelType {
    init(original: PaymentSection, items: [PaymentCellSelection]) {
        self = original
        self.items = items
    }
}

extension PaymentSection: Equatable {
    static func == (lhs: PaymentSection, rhs: PaymentSection) -> Bool {
        return lhs.header == rhs.header
    }
}
