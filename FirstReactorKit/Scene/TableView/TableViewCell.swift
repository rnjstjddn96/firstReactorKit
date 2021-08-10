//
//  TableViewCell.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/06.
//

import Foundation
import SnapKit
import RxGesture
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    let evnetImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return subTitleLabel
    }()
    
    var imageTap: Observable<ControlEvent<UITapGestureRecognizer>.Element> {
        return evnetImageView.rx.tapGesture().when(.recognized)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(evnetImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    private func autoLayout() {
        evnetImageView.snp.makeConstraints {
            $0.top.leading.height.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(evnetImageView.snp.right).offset(10)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalTo(evnetImageView.snp.right).offset(10)
            
        }
    }
}
