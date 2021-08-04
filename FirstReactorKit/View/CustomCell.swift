//
//  CustomCell.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    static let ID = "CustomCell"
    
    let label = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .build()
    
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(iv)
        
        iv.snp.makeConstraints { create in
            create.left.top.bottom.equalToSuperview()
            create.width.equalTo(iv.snp.height)
        }
        
        label.snp.makeConstraints { create in
            create.left.equalTo(iv.snp.right).offset(30)
            create.centerY.equalToSuperview()
        }
    }
    
    func setCellUI(text: String, image: UIImage) {
        self.label.text = text
        self.iv.image = image
    }
    
}
