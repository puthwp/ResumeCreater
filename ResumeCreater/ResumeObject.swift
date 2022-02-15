//
//  ResumeObject.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 14/2/2565 BE.
//

import Foundation
import RealmSwift

class ResumeStore: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    dynamic var firstname: String?
    dynamic var lastname: String?
    @Persisted var objective: String?
    @Persisted var picture: String?
    @Persisted var email: String?
    @Persisted var phone: String?
    @Persisted var address: String?
    @Persisted var totalYearsExperience: Int?
    @Persisted var skill: List<String>
    @Persisted var education: List<EducationStore>
    @Persisted var works: List<WorkStore>
    @Persisted var projects: List<ProjectStore>
    @Persisted var created: Date = Date()
}

class EducationStore: Object {
    @Persisted var className: String?
    @Persisted var passingYear: String?
    @Persisted var gpa: String?
}

class WorkStore: Object {
    @Persisted var companyName: String?
    @Persisted var duration: DurationStore?
}

class ProjectStore: Object {
    @Persisted var projectName: String?
    @Persisted var teamSize: Int?
    @Persisted var summary: String?
    @Persisted var technology: String?
    @Persisted var role: String?
    @Persisted var createdDate: Date = Date()
}

class DurationStore: Object {
    @Persisted var start: Date?
    @Persisted var end: Date?
}
