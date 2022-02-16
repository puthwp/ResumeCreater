//
//  ResumeMainDataAddCell.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation
import UIKit
protocol DataCell {
    static var identifier: String { get }
}

class ResumeMainDataAddCell:UITableViewCell, DataCell{
    static let identifier: String = "ResumeMainDataAddCellID"
    @IBOutlet weak var title: UIButton!
}
