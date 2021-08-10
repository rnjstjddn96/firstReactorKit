//
//  Event.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import Foundation
import UIKit

enum CardViewMode {
    case full_CardViewMode
    case card_CardViewMode
}

enum CardViewType {
    case event_CardViewType(bgImage: UIImage, eventTitle: String, eventSubTitle: String)
    
    var backgroundImage: UIImage? {
        switch self {
        case .event_CardViewType(let bgImage, _, _):
            return bgImage
        }
    }
}


class EventData {
    var viewMode: CardViewMode = .card_CardViewMode
    let viewType: CardViewType
    var eventImage: UIImage? = nil
    var eventTitle: String? = nil
    var eventSubTitle: String? = nil
    
    init(viewType: CardViewType) {
        self.viewType = viewType
        switch viewType {
        case .event_CardViewType(let bgImage, let eventTitle, let eventSubTitle):
            self.eventImage = bgImage.imageWith(newSize: CGSize(width: 375, height: 450))
            self.eventTitle = eventTitle
            self.eventSubTitle = eventSubTitle
        }
        
    }
}

extension UIImage {
    
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size:newSize)
        let image = renderer.image { _ in
            draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
    
}
