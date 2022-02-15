//
//  ResumeItemListCell.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//

import Foundation
import UIKit

class ResumeAddItemCollectionCell: UICollectionViewCell {
    static let identifier = "ResumeAddItemCollectionCellID"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemMint.cgColor
        self.layer.borderWidth = 2
    }
}
