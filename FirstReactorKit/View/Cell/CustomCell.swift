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
    static let ID = "customCell"
    
    let cardNameLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    let cardCompanyLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    let mainCardLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    let cardImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.contentView.backgroundColor = .systemIndigo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.contentView.addSubview(cardNameLabel)
        self.contentView.addSubview(cardImageView)
        
        cardImageView.snp.makeConstraints { create in
            create.left.top.bottom.equalTo(self.contentView)
            create.width.equalTo(cardImageView.snp.height)
        }
        
        cardNameLabel.snp.makeConstraints { create in
            create.left.equalTo(cardImageView.snp.right).offset(30)
            create.right.equalTo(self.contentView.snp.right).offset(-30)
            create.centerY.equalToSuperview()
        }
    }
    
    func bindUI(text: String, image: UIImage) {
        self.contentView.addDivider(color: .black, height: 1, padding: 10,
                                    on: .BOTTOM(guide: self.contentView.snp.bottom))
        self.cardNameLabel.text = text
        self.cardImageView.image = image
    }
    
}
