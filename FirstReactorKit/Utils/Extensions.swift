//
//  Extensions.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import UIKit
import ReactorKit

extension String {
    var asImage: UIImage {
        guard let image = UIImage(named: self) else { return UIImage() }
        return image 
    }
}


extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    var previous: Self? {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let previous = all.index(before: idx)
        guard previous >= all.startIndex else { return nil }
        return all[previous]
    }

    var next: Self? {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        guard next < all.endIndex else { return nil }
        return all[next]
    }
}
