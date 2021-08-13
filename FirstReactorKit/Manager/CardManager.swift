//
//  CardManager.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/13.
//

import Foundation
import ReactorKit
import UIKit

class CardManager {
    static let shared = CardManager()
    private init() { }
    
    var selectedCard = BehaviorSubject<CardAccountInfo?>(value: nil)
    var mainCard = BehaviorSubject<CardAccountInfo?>(value: nil)
}
