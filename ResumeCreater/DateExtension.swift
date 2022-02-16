//
//  DateExtension.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation
import UIKit

extension Date {
    func toFormatString(_ format: String? = "MMM yyyy") -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
}

extension UIImage {
    func saveToDocumentFolder() -> String {
        if let data = self.pngData() {
            let fileName = "\(UUID().uuidString).png"
            guard let pathURL = FileManager.documentPath?.appendingPathComponent(fileName) else {
                return ""
            }
            try? data.write(to: pathURL)
            return fileName
        }
        return ""
    }
}

extension FileManager {
    static var documentPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}

