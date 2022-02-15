//
//  ResumeMainInteractor.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

protocol ResumeMainBusinessLogic {
    func fetchResumeProfile()
}

protocol ResumeMainDataStore {
    var resumeInfo: ResumeStore { get set }
    var firstname: String? { get set }
    var lastname: String? { get set }
}

class ResumeMainInteractor: ResumeMainBusinessLogic, ResumeMainDataStore {
    var presenter: ResumeMainPresentationLogic?
    var worker: ResumeMainWorker?
    var resumeInfo: ResumeStore
    var firstname: String?
    var lastname: String?
    
    init() {
        resumeInfo = ResumeStore()
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
    
    func fetchResumeProfile() {
        let response = ResumeMain.Response()
        self.presenter.presentResumeProfile(response: response)
    }
}
