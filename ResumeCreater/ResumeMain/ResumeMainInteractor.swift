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

    }
}
