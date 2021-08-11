//
//  BaseTableViewCell.swift
//  FirstReactorKit
//
//  Created by imform-mm-2101 on 2021/08/09.
//

import Foundation
import UIKit
import Then
import SnapKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize() {
        
    }
    
    func configureUI() {
        
    }
    
    func setupConstraints() {
        
    }
}

extension BaseTableViewCell {
    func withSelectionStyle(style: UITableViewCell.SelectionStyle) {
        self.selectionStyle = style
    }
}
