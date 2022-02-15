//
//  DateExtension.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation

extension Date {
    func toFormatString(_ format: String? = "MMM yyyy") -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
}
