//
//  ResumeMainInteractor.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

protocol ResumeMainBusinessLogic {}

protocol ResumeMainDataStore {
    var resumeInfo: Resume { get set }
    var firstname: String? { get set }
    var lastname: String? { get set }
}

class ResumeMainInteractor: ResumeMainBusinessLogic, ResumeMainDataStore {
    var presenter: ResumeMainPresentationLogic?
    var worker: ResumeMainWorker?
    var resumeInfo: Resume
    var firstname: String?
    var lastname: String?
    
    init() {
        resumeInfo = Resume()
        resumeInfo.firstname = firstname
        resumeInfo.lastname = lastname
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(resumeInfo)
            }
        }catch {
            print(error)
        }
    }
}
