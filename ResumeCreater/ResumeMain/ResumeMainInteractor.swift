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
<<<<<<< HEAD
    func saveResumeObject(request: ResumeMain.Request)
}

protocol ResumeMainDataStore {
    var resumeID: String? { get set }
    var resumeInfo: ResumeStore? { get set }
=======
}

protocol ResumeMainDataStore {
    var resumeInfo: ResumeStore { get set }
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
    var firstname: String? { get set }
    var lastname: String? { get set }
}

class ResumeMainInteractor: ResumeMainBusinessLogic, ResumeMainDataStore {
    var presenter: ResumeMainPresentationLogic?
    var worker: ResumeMainWorker?
<<<<<<< HEAD
    var resumeInfo: ResumeStore?
=======
    var resumeInfo: ResumeStore
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
    var firstname: String?
    var lastname: String?
    var resumeID: String?
    
<<<<<<< HEAD
    func fetchResumeProfile() {
=======
    init() {
        resumeInfo = ResumeStore()
        resumeInfo.firstname = firstname
        resumeInfo.lastname = lastname
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
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
    
<<<<<<< HEAD
    func saveResumeObject(request: ResumeMain.Request) {
        let mirror = Mirror(reflecting: request)
        for (_,attribute) in mirror.children.enumerated() {
            if nil != attribute.value {
                switch attribute.label {
                case "firstname":
                    resumeInfo?.firstname = attribute.value as! String
                case "lastname":
                    resumeInfo?.lastname = attribute.value as! String
                case "objective":
                    resumeInfo?.objective = attribute.value as! String
                case "picture":
                    resumeInfo?.picture = attribute.value as! String
                case "email":
                    resumeInfo?.email = attribute.value as! String
                case "phone":
                    resumeInfo?.phone = attribute.value as! String
                case "address":
                    resumeInfo?.address = attribute.value as! String
                    
                    
                default:
                    ()
                }
            }
        }
        resumeInfo?.firstname = request.firstname
=======
    func fetchResumeProfile() {
        let response = ResumeMain.Response()
        self.presenter.presentResumeProfile(response: response)
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
    }
}
