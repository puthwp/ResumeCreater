//
//  ResumeListWorker.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

class ResumeListWorker {
    func saveToDatabase(firstname: String?, lastname: String?) -> Result<String, RSMError>? {
        do {
            let realm = try Realm()
            let resume = ResumeStore()
            resume.firstname = firstname
            resume.lastname = lastname
            try realm.write {
                realm.add(resume)
            }
            return .success(resume._id)
        } catch {
            print(error)
            return .failure(.savedError)
        }
    }
}
