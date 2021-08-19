//
//  NewEventCell.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/19.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa
import Hero

class NewEventCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    var containerView: UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .white
        return uiView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:18)
        label.textColor = UIColor.black
        label.backgroundColor = .white
        label.text = "titleLabel"
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12)
        label.textColor = UIColor.black
        label.backgroundColor = .white
        label.text = "subTitleLabel"
        return label
    }()
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
        
    func setUpCell() {
        imageView.clipsToBounds = true
        imageView.contentMode = .bottom
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.addSubview(containerView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.left.equalTo(contentView.snp.left)
            $0.right.equalTo(contentView.snp.right)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top)
            $0.left.equalTo(containerView.snp.left)
            $0.right.equalTo(containerView.snp.right)
            $0.height.equalTo(65.asPercent(with: .WIDTH))
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
            $0.left.equalTo(imageView.snp.left).offset(5.0.asPercent(with: .WIDTH))
            $0.width.equalTo(80.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .WIDTH))
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
            $0.left.equalTo(imageView.snp.left).offset(5.0.asPercent(with: .WIDTH))
            $0.width.equalTo(80.asPercent(with: .WIDTH))
            $0.height.equalTo(10.0.asPercent(with: .WIDTH))
        }
       
    }
    
}

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}
