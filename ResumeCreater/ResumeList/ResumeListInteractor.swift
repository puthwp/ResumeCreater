//
//  ResumeListInteractor.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RealmSwift

protocol ResumeListBusinessLogic {
    func saveName(firstname: String, lastname: String)
    func didSelectedItem(_ item: ResumeList.ViewModel.Item?)
    func fetchAllResumes()
}

protocol ResumeListDataStore {
    var firstname: String? { get set }
    var lastname: String? { get set }
    var resumeID: String? { get set }
}

class ResumeListInteractor: ResumeListBusinessLogic, ResumeListDataStore {
    var firstname: String?
    var lastname: String?
    var resumeID: String?
    
    var presenter: ResumeListPresentationLogic?
    var worker: ResumeListWorker?
    
    func fetchAllResumes() {
        do {
            let realm = try Realm()
            let resumeItems = realm.objects(ResumeStore.self).sorted(byKeyPath: "created" , ascending: false)
            let response = ResumeList.Response(items: resumeItems.map{ $0 })
            presenter?.presentAllResume(response: response)
        }catch {
            let response = ResumeList.Response(error: .fetchedError)
            presenter?.presentError(response: response)
            print(error)
        }
    }
    
    func didSelectedItem(_ item: ResumeList.ViewModel.Item?) {
        self.resumeID = item?.id
        presenter?.presentDidSelectedItem()
    }
    
    func saveName(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        let worker = ResumeListWorker()
        if let result = worker.saveToDatabase(firstname: firstname, lastname: lastname) {
            switch result {
            case .success(let token):
                self.resumeID = token
                presenter?.presentNameDidSaved()
            case .failure(let error):
                let response = ResumeList.Response(error: error)
                presenter?.presentError(response: response)                
            }
        }else {
            presenter?.presentNameDidSaved()            
        }
    }
}
