//
//  ResumeListModels.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ResumeList {
    static let namingResumeSegue = "NamingResumeSegue"
    static let newResumeSegue = "NewResumeSegue"
    static let editResumeSegue = "EditResumeSegue"
    struct Request {
        var name: String?
    }
    struct Response {
        var items: [Resume]?
    }
    struct ViewModel {
        var items: [item]?
        struct item {
            var id: String?
            var name: String?
            var photo: UIImage?
            
            init(_ item: Resume) {
                id = item._id
                name = (item.firstname ?? "Unknown") + " " + (item.lastname ?? "")
                if let url = item.picture {
                    photo = UIImage(contentsOfFile: url)
                }
            }
        }
    }
}
