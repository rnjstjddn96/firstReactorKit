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
