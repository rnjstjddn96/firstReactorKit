//
//  CardView.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/10.
//

import Foundation
import UIKit
import SnapKit

class CardView: UIView {
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    var containerView: UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .systemBlue
        return uiView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:18)
        label.textColor = UIColor.black
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12)
        label.textColor = UIColor.black
        return label
    }()
    
    var eventData: EventData
    
    init(eventData: EventData) {
        self.eventData = eventData

        super.init(frame: .zero)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        backgroundColor = .clear
        addSubview(shadowView)
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        
        switch eventData.viewType {
        case .event_CardViewType:
            guard let eventImage = eventData.eventImage else { return }
            guard let eventTitle = eventData.eventTitle else { return }
            guard let eventSubTitle = eventData.eventSubTitle else { return }
            imageView.image = eventImage
            titleLabel.text = eventTitle
            subTitleLabel.text = eventSubTitle
        }
        
        if eventData.viewMode == .card_CardViewMode {
            convertContainerViewToCardView()
        } else {
            convertContainerViewToFullScreen()
        }
       
    }
    
    func convertContainerViewToCardView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        updateLayout(viewMode: .card_CardViewMode)
        
    }
    
    func convertContainerViewToFullScreen() {
        containerView.layer.cornerRadius = 0
        containerView.layer.masksToBounds = true
        updateLayout(viewMode: .full_CardViewMode)
    }
    
    func updateLayout(viewMode: CardViewMode) {
        switch viewMode {
        case .card_CardViewMode:
            containerView.snp.makeConstraints {
                $0.width.height.equalTo(90.0.asPercent(with: .WIDTH))
            }
            
            shadowView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.left.equalTo(containerView.snp.left)
                $0.right.equalTo(containerView.snp.right)
                $0.bottom.equalTo(containerView.snp.bottom)
            }
            
            imageView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.left.equalTo(containerView.snp.left)
                $0.right.equalTo(containerView.snp.right)
                $0.height.equalTo(65.asPercent(with: .WIDTH))
            }
            
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
                $0.left.equalTo(imageView.snp.left).offset(2.0.asPercent(with: .WIDTH))
                $0.width.equalTo(imageView.snp.width)
                $0.height.equalTo(10.0.asPercent(with: .WIDTH))
            }
            
            subTitleLabel.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
                $0.left.equalTo(imageView.snp.left).offset(2.0.asPercent(with: .WIDTH))
                $0.width.equalTo(imageView.snp.width)
                $0.height.equalTo(10.0.asPercent(with: .WIDTH))
            }
        case .full_CardViewMode:
            containerView.snp.makeConstraints {
                $0.width.height.equalToSuperview()
            }
            
            shadowView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.left.equalTo(containerView.snp.left)
                $0.right.equalTo(containerView.snp.right)
                $0.bottom.equalTo(containerView.snp.bottom)
            }
            
            imageView.snp.makeConstraints {
                $0.top.equalTo(containerView.snp.top)
                $0.left.equalTo(containerView.snp.left)
                $0.right.equalTo(containerView.snp.right)
                $0.height.equalTo(45.asPercent(with: .HEIGHT))
            }
        }
    }
    
    
    
    
    
    
}
