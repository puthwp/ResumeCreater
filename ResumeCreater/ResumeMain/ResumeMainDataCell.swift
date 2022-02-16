//
//  ResumeMainDataCell.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation
import UIKit

class ResumeMainDataCell: UITableViewCell {
    static let identifier = "ResumeMainDataCellID"
    var viewModel: ResumeMain.ViewModel.DisplayModel?
    var editButtonClosure: () = {}()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    func setViewModel(_ viewModel: ResumeMain.ViewModel.DisplayModel?) {
        guard let item = viewModel else {
            return
        }
        titleLabel.text = item.title
        detailLabel.text = item.description
        
    }
    
    @IBAction func didTapEditProfile(sender: UIButton?) {
        editButtonClosure
    }
    
}
