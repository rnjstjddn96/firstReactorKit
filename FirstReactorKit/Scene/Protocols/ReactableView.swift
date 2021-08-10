//
//  BaseViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/10.
//

import Foundation
import UIKit
import ReactorKit
import Then
import SnapKit

protocol ReactableView: View {
    typealias ReactorAction = Reactor.Action
    var disposeBag: DisposeBag { get set }
    var viewDidLoadSubject: PublishSubject<ReactorAction> { get set }
    var viewWillAppearSubject: PublishSubject<ReactorAction> { get set }
}
