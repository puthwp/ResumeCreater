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
    func saveResumeObject(request: ResumeMain.Request)
}

protocol ResumeMainDataStore {
    var resumeID: String? { get set }
    var resumeInfo: ResumeStore? { get set }
    var firstname: String? { get set }
    var lastname: String? { get set }
}

class ResumeMainInteractor: ResumeMainBusinessLogic, ResumeMainDataStore {
    var presenter: ResumeMainPresentationLogic?
    var worker: ResumeMainWorker?
    var resumeInfo: ResumeStore?
    var firstname: String?
    var lastname: String?
    var resumeID: String?
    

    func fetchResumeProfile() {
        do {
            let realm = try Realm()
            if let item =  realm.object(ofType: ResumeStore.self, forPrimaryKey: resumeID) {
                resumeInfo = item
                let response = ResumeMain.Response(resumeInfo: item)
                self.presenter?.presentResumeProfile(response: response)
            }else {
                let response = ResumeMain.Response(resumeInfo: nil, error: .somethingwrong)
                self.presenter?.presentError(response: response)
            }
            
        } catch {
            let response = ResumeMain.Response(resumeInfo: nil, error: .fetchedError)
            presenter?.presentError(response: response)
            print(error)
        }
    }
    
    func saveResumeObject(request: ResumeMain.Request) {
        let worker = ResumeMainWorker()
        worker.saveResumeObject(resumeID!, request: request) { [weak self] error in
            if error != nil {
                let response = ResumeMain.Response(resumeInfo: nil, error: error)
                self?.presenter?.presentError(response: response)
            }else {
                var response = ResumeMain.Response(resumeInfo: nil)
                self?.presenter?.presentSuccess(response: response)
            }
        }

    }
}
