//
//  ResumeListModels.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
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
<<<<<<< HEAD
        var error: RSMError?
=======
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
        var items: [ResumeStore]?
    }
    struct ViewModel {
        var errorMsg: String?
        var items: [Item]?
        struct Item {
            var id: String?
            var firstname: String?
            var lastname: String?
            var date: String?
            var photo: UIImage?
            
            init(_ item: ResumeStore) {
                id = item._id
                firstname = item.firstname ?? "Unknown"
                lastname = item.lastname ?? ""
                date = item.created.formatted()
                if let url = item.picture {
                    photo = UIImage(contentsOfFile: url)
                }
            }
        }
    }
}
