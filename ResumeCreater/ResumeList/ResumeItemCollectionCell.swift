//
//  ResumeItemCell.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation
import UIKit
 
class ResumeItemCollectionCell: UICollectionViewCell {
    static let identifier = "ResumeItemCollectionCellID"
    @IBOutlet weak var profileImageWrapper: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    var viewModel: ResumeList.ViewModel.Item?
    
    func setData(_ viewModel: ResumeList.ViewModel.Item?) {
        guard let item = viewModel else { return }
        firstnameLabel.text = item.firstname
        lastnameLabel.text = item.lastname
        dateCreatedLabel.text = item.date
        profileImageView.image = item.photo
        layoutSetup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSetup()
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        layoutSetup()
    }
    
    func layoutSetup() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileImageWrapper.layer.cornerRadius = self.profileImageWrapper.bounds.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        firstnameLabel.text = ""
        lastnameLabel.text = ""
        dateCreatedLabel.text = ""
        profileImageView.image = UIImage(systemName: "person")
    }
}
