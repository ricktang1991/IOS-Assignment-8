//
//  FilterCollectionViewCell.swift
//  Assignment 8
//
//  Created by 桑染 on 2020-05-25.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    let filterLabel: UILabel = {
        let fl = UILabel()
        fl.translatesAutoresizingMaskIntoConstraints = false
        fl.textAlignment = .center
        fl.font = UIFont.boldSystemFont(ofSize: 15)
        return fl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(filterLabel)
        
        filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
