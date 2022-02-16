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
    func setViewModel(_ viewModel: ResumeMain.ViewModel.DisplayModel?) {
        guard let item = viewModel else {
            return
        }
        
    }
    
}
