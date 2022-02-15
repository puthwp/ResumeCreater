//
//  ResumeListInteractor.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeListBusinessLogic {
    func saveName(firstname: String, lastname: String)
    func fetchAllResumes()
}

protocol ResumeListDataStore {
    var firstname: String? { get set }
    var lastname: String? { get set }
}

class ResumeListInteractor: ResumeListBusinessLogic, ResumeListDataStore {
    var firstname: String?
    var lastname: String?
    
    var presenter: ResumeListPresentationLogic?
    var worker: ResumeListWorker?
    
    func fetchAllResumes() {
        let response = ResumeList.Response()
        presenter?.presentAllResume(response: response)
    }
    
    func saveName(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        presenter?.presentNameDidSaved()
    }
}
