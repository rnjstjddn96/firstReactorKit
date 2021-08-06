//
//  Event.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import Foundation
import UIKit

class EventData {
    var eventImage: UIImage!
    var eventTitle: String!
    var eventSubTitle: String!
    
    init(eventImage: UIImage, eventTitle: String, eventSubTitle: String) {
        self.eventImage = eventImage
        self.eventTitle = eventTitle
        self.eventSubTitle = eventSubTitle
    }
}
