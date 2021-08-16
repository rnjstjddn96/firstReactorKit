//
//  CardCell.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/04.
//

import Foundation
import UIKit
import SnapKit
import ReactorKit

class CardCell: BaseTableViewCell {
    
    //MARK: 카드 이미지
    let cardImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    //MARK: 카드 별칭
    let cardNameLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    //MARK: 카드사
    let cardCompanyLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    
    //MARK: 대표결제 수단
    let mainCardLabel = UILabel.Builder()
        .withFont(.systemFont(ofSize: 10))
        .withTextColor(.black)
        .withMaxLine(limit: 1)
        .build()
    
    //MARK: 카드 선택 체크
    let selectedCheckView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    //MARK: 대표카드 선택
    let mainCheckView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    
    override func initialize() {
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupConstraints() {
        self.addDivider(color: .darkGray, height: 1, padding: 20,
                        on: .BOTTOM(guide: self.contentView.snp.bottom))
        
        self.addSubview(cardNameLabel)
        self.addSubview(cardCompanyLabel)
        self.addSubview(cardImageView)
        

        cardImageView.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.height.equalTo(50)
            create.width.equalTo(80)
            create.left.equalToSuperview().offset(20)
        }

        cardNameLabel.snp.makeConstraints { create in
            create.left.equalTo(cardImageView.snp.right).offset(30)
            create.right.lessThanOrEqualTo(self.contentView.snp.right)
            create.top.equalTo(cardImageView)
        }

        cardCompanyLabel.snp.makeConstraints { create in
            create.left.equalTo(cardImageView.snp.right).offset(30)
            create.right.lessThanOrEqualTo(self.contentView.snp.right)
            create.bottom.equalTo(cardImageView)
        }
    }
    
    override func configureUI() {
        self.contentView.backgroundColor = .systemIndigo
        self.withSelectionStyle(style: .none)
    }
}

extension CardCell: View {
    typealias Reactor = CardCellReactor
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { $0.account }
            .bind { account in
                let cardCompanyName = CardCompany.init(rawValue: account.cardCompCode)?.name ?? ""
                self.cardCompanyLabel.text = cardCompanyName + "(\(account.cardLastNum))"
                self.cardImageView.image = account.image
                self.cardNameLabel.text = account.cardName
            }
            .disposed(by: disposeBag)
    }
}
