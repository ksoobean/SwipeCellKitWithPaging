//
//  CollectionViewCell.swift
//  SwipeCellKitSample
//
//  Created by master on 2020/04/24.
//  Copyright © 2020 ksb. All rights reserved.
//

import UIKit
import SwipeCellKit

class CollectionViewCell: SwipeCollectionViewCell {
    
    @IBOutlet weak var cellContentView: UIView!
    // 라벨
    @IBOutlet weak var cellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellContentView.layer.cornerRadius = 10
        self.cellContentView.backgroundColor = .systemGray
    }
    
    public func configCell(text: String) {
        self.cellLabel.text = text
    }

}
