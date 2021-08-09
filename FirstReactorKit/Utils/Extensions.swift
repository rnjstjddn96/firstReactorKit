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
