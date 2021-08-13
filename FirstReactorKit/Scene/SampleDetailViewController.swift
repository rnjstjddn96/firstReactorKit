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
