//
//  DataCollector.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 15/2/2565 BE.
//

import Foundation
import RealmSwift

class DataCollector {
    
    let shared = DataCollector()
    
    init() {
        _ = try! Realm()
    }
    
    convenience init(firstName: String, lastname: String?) {
        self.init()
        let resume = ResumeStore()
        resume.firstname = firstName
        resume.lastname = lastname
    }
}

extension ResumeStore {
    func update() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch {
            print(error)
        }
    }
}
