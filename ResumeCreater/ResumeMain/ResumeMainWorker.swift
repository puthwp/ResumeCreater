//
//  ResumeMainWorker.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

class ResumeMainWorker {
    func saveResumeObject(_ id: String, request: ResumeMain.Request, completeBlock: @escaping (RSMError?) -> Void) {
        let mirror = Mirror(reflecting: request)
        
        do {
            let realm = try Realm()
            let resumeInfo = realm.object(ofType: ResumeStore.self, forPrimaryKey: id)
            try realm.write {
                for (_,attribute) in mirror.children.enumerated() {
                    if let value = attribute.value as? String, !value.isEmpty {
                        switch attribute.label {
                        case "firstname":
                            resumeInfo?.firstname = value
                        case "lastname":
                            resumeInfo?.lastname = value
                        case "objective":
                            resumeInfo?.objective = value
                        case "profileImage":
                            resumeInfo?.picture = value
                        case "email":
                            resumeInfo?.email = value
                        case "phone":
                            resumeInfo?.phone = value
                        case "address":
                            resumeInfo?.address = value
                        default:
                            ()
                        }
                    }
                }
                completeBlock(nil)
            }
        } catch {
            print(error)
            completeBlock(.savedError)
        }
    }
}
