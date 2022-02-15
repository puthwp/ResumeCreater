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
        do {
            let realm = try Realm()
            let resumeItems = realm.objects(ResumeStore.self).sorted(byKeyPath: "created" , ascending: false)
            let response = ResumeList.Response(items: resumeItems.map{ $0 })
            presenter?.presentAllResume(response: response)
        }catch {
            
            print(error)
        }
    }
    
    func saveName(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        presenter?.presentNameDidSaved()
    }
}
