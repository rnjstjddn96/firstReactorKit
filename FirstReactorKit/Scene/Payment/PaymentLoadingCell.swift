//
//  PaymentLoadingCell.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/13.
//

import Foundation
import UIKit

class PaymentLoadingCell: BaseTableViewCell {
    
    //MARK: 로딩뷰
    let skeletonCardViewLayer = CAGradientLayer()
    let skeletonCardView = UIView()
    
    let skeletonTextViewLayer = CAGradientLayer()
    let skeletonTextView = UIView()
    
    let skeletonShortTextViewLayer = CAGradientLayer()
    let skeletonShortTextView = UIView()
    
    override func configureUI() {
        self.withSelectionStyle(style: .none)
    }
    
    override func setupConstraints() {
        setSkeletionViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        skeletonTextViewLayer.frame = skeletonTextView.bounds
        skeletonTextViewLayer.cornerRadius = skeletonTextView.bounds.height / 2
        
        skeletonShortTextViewLayer.frame = skeletonShortTextView.bounds
        skeletonShortTextViewLayer.cornerRadius = skeletonShortTextView.bounds.height / 2

        skeletonCardViewLayer.frame = skeletonCardView.bounds
        skeletonCardViewLayer.cornerRadius = 10
    }
    
    private func setSkeletionViews() {
        self.addSubview(skeletonCardView)
        self.addSubview(skeletonTextView)
        self.addSubview(skeletonShortTextView)
        
        skeletonCardView.snp.makeConstraints { create in
            create.centerY.equalToSuperview()
            create.height.equalTo(60)
            create.width.equalTo(100)
            create.left.equalToSuperview().offset(20)
        }
        
        skeletonTextView.snp.makeConstraints { create in
            create.top.equalTo(skeletonCardView)
            create.left.equalTo(skeletonCardView.snp.right).offset(20)
            create.width.equalTo(120)
            create.height.equalTo(20)
        }
        
        skeletonShortTextView.snp.makeConstraints { create in
            create.bottom.equalTo(skeletonCardView)
            create.left.equalTo(skeletonCardView.snp.right).offset(20)
            create.width.equalTo(80)
            create.height.equalTo(20)
        }
        
        setupLoadingEffect()
    }
}

extension PaymentLoadingCell: SkeletonLoadable {
    func setupLoadingEffect() {
        skeletonTextViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonTextViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonTextView.layer.addSublayer(skeletonTextViewLayer)

        skeletonShortTextViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonShortTextViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonShortTextView.layer.addSublayer(skeletonShortTextViewLayer)
        
        skeletonCardViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
        skeletonCardViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
        skeletonCardView.layer.addSublayer(skeletonCardViewLayer)
        
        let cardImageGroup = makeAnimationGroup()
        cardImageGroup.beginTime = 0.0
        skeletonCardViewLayer.add(cardImageGroup, forKey: "backgroundColor")
        
        let textGroup = makeAnimationGroup(previousGroup: cardImageGroup)
        skeletonTextViewLayer.add(textGroup, forKey: "backgroundColor")

        let shortTextGroup = makeAnimationGroup(previousGroup: cardImageGroup)
        skeletonShortTextViewLayer.add(shortTextGroup, forKey: "backgroundColor")
        
        skeletonShortTextView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}
