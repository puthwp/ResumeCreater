//
//  ResumeObject.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 14/2/2565 BE.
//

import Foundation
import RealmSwift

class Resume: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var firstname: String?
    @Persisted var lastname: String?
    @Persisted var objective: String?
    @Persisted var picture: String?
    @Persisted var email: String?
    @Persisted var address: String?
    @Persisted var totalYearsExperience: Int?
    @Persisted var skill: List<String>
    @Persisted var education: List<Education>
    @Persisted var works: List<Work>
    @Persisted var projects: List<Project>
}

class Education: Object {
    @Persisted var className: String?
    @Persisted var passingYear: String?
    @Persisted var gpa: String?
}

class Work: Object {
    @Persisted var companyName: String?
    @Persisted var duration: Duration?
}

class Project: Object {
    @Persisted var projectName: String?
    @Persisted var teamSize: String?
    @Persisted var summary: String?
    @Persisted var technology: String?
    @Persisted var role: String?
}

class Duration: Object {
    @Persisted var start: Date?
    @Persisted var end: Date?
}
