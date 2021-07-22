//
//  ImageViewBuilder.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/07/22.
//

import Foundation
import UIKit

extension UIImageView {
    typealias Builder = ImageViewBuilder
}

class ImageViewBuilder: BuilderType {
    private var frame: CGRect = .zero
    private var image: UIImage = UIImage()
    private var contentMode: UIView.ContentMode = .scaleAspectFit
    
    func withFrame(_ frame: CGRect) -> ImageViewBuilder {
        self.frame = frame
        return self
    }
    
    func withImage(_ image: UIImage) -> ImageViewBuilder {
        self.image = image
        return self
    }
    
    func withContentMode(contentMode: UIView.ContentMode) -> ImageViewBuilder {
        self.contentMode = contentMode
        return self
    }

    func build() -> UIImageView {
        let imageView: UIImageView = .init(frame: .zero)
        imageView.frame = self.frame
        imageView.image = self.image
        imageView.contentMode = self.contentMode
        return imageView
    }
}
