//
//  CollectionViewCell.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/06.
//

import Foundation
import SnapKit

class CollectionViewCell<View: UIView>: UICollectionViewCell {
    
    var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setUpViews()
        }
    }
    
    private func setUpViews() {
        guard let cellView = cellView else { return }
        
        addSubview(cellView)
        cellView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
        
    
}
