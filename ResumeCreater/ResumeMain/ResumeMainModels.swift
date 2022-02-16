//
//  ResumeMainModels.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ResumeDataType {
    case firstname
    case lastname
    case objective
    case picture
    case email
    case phone
    case address
    case totalYearsExperience
    case skill
    case education
    case works
    case projects
    case add
}

enum ResumeMain {
    static let display: [[ResumeDataType]] = [
        [
            .objective,
            .email,
            .phone,
            .address,
            .totalYearsExperience,
            .skill
        ],
        [
            .education
        ],
        [
            .works
        ],
        [
            .projects
        ]
    ]
    struct Request {
        var image: UIImage?
        var profileEdited: Profile?
        struct Profile {
            var profileImage: String?
            var firstname: String?
            var lastname: String?
            var objective: String?
            var phone: String?
            var email: String?
            var address: String?
            var skills: [String]?
            var works: [ResumeMain.ViewModel.WorkViewModel]?
            var education: [ResumeMain.ViewModel.EducationViewModel]?
            var projects: [ResumeMain.ViewModel.ProjectViewModel]?            
        }
    }
    
    struct Response {
        let resumeInfo: ResumeStore?
        var error: RSMError?
        var msg: String?
    }
    
    struct ViewModel {
        var displayItems: [[ResumeMain.ViewModel.DisplayModel]]?
        var profileImage: UIImage?
        var firstname: String?
        var lastname: String?
        var objective: String?
        var phone: String?
        var email: String?
        var address: String?
        var skills: [String]?
        var works: [ResumeMain.ViewModel.DisplayModel]?
        var education: [ResumeMain.ViewModel.DisplayModel]?
        var projects: [ResumeMain.ViewModel.DisplayModel]?
        var msg: String?
        
        
        
        init(_ profile: ResumeStore) {
            if let url = FileManager.documentPath?.appendingPathComponent(profile.picture ?? "") as? URL {
                do {
                    let imageData = try Data(contentsOf: url)
                    let image = UIImage(data: imageData)
                    profileImage = image
                } catch {
                    print(error)
                }
            }
            firstname = profile.firstname
            lastname = profile.lastname
//            objective = profile.objective
//            phone = profile.phone
//            email = profile.email
//            address = profile.address
//            skills = profile.skill.map { $0 }
            
            let objective = DisplayModel(type: .objective,
                                         title: "Career Objective",
                                         value: profile.objective,
                                         description: nil)
            let phone = DisplayModel(type: .phone,
                                     title: "Phone Number",
                                     value: profile.phone,
                                     description: nil)
            let email = DisplayModel(type: .email,
                                     title: "Email",
                                     value: profile.email,
                                     description: nil)
            let address = DisplayModel(type: .address,
                                       title: "Location",
                                       value: profile.address,
                                       description: nil)
            let skills = DisplayModel(type: .skill,
                                      title: "Skill",
                                      value: profile.skill.map { $0 }
                                        .joined(separator: ", "),
                                      description: "Seperate by \",\" on each")
            displayItems = [[objective, phone, email, address, skills]]
            let addButtonWork = DisplayModel(type: .add,
                                             title: "",
                                             value: nil,
                                             description: nil)
            let addButtonEducation = DisplayModel(type: .add,
                                                  title: "",
                                                  value: nil,
                                                  description: nil)
            let addButtonProject = DisplayModel(type: .add,
                                                title: "",
                                                value: nil,
                                                description: nil)
            works = profile.works.sorted{ $0.duration?.start ?? Date() < $1.duration?.start ?? Date() }.map { .init($0) }
            works?.append(addButtonWork)
            education = profile.education.sorted { Int($0.passingYear ?? "0") ?? 0 > Int($1.passingYear ?? "0") ?? 1 }.map { .init($0) }
//            education.append(addButtonEducation)
            projects = profile.projects.sorted { $0.createdDate > $1.createdDate }.map { .init($0) }
//            projects.append(addButtonProject)
            displayItems?.append(works ?? [])
            displayItems?.append(education ?? [])
            displayItems?.append(projects ?? [])
        }
        
        init(_ msg: String) {
            self.msg = msg
        }
        
        init() {
            
        }
        
        struct DisplayModel {
            var type: ResumeDataType
            var title: String?
            var value: String?
            var description: String?
            var cellIdentifier: String = ResumeMainDataCell.identifier
            var className: DataCell
            init(type: ResumeDataType, title: String?, value: String?, description: String?) {
                self.type = type
                self.title = title
                self.value = value
                self.description = description
                className = ResumeMainDataCell.self as! DataCell
            }
            
            init(_ work: WorkStore) {
                self.title = work.companyName
                self.value = [
                    work.duration?.end?.toFormatString() ?? "",
                    "-",
                    work.duration?.start?.toFormatString() ?? ""
                ].joined(separator: " ")
                self.type = .works
                self.description = ""
                self.cellIdentifier = ResumeMainDataCell.identifier
                self.className = ResumeMainDataCell.self as! DataCell
            }
            
            init(_ education: EducationStore) {
                self.title = education.passingYear
                self.value = (education.className ?? "Unknown") + "(\(education.gpa ?? "0.0"))"
                self.type = .education
                self.description = ""
                self.cellIdentifier = ResumeMainDataCell.identifier
                self.className = ResumeMainDataCell.self as! DataCell
            }
            
            init(_ project: ProjectStore) {
                self.title = [
                    project.projectName ?? "",
                    "(",
                    project.role ?? "",
                    ")"
                ].joined()
                self.value = [
                    "Using",
                    project.technology ?? "",
                    "to",
                    project.summary ?? ""
                ].joined(separator: " ")
                self.type = .projects
                self.description = ""
                self.cellIdentifier = ResumeMainDataCell.identifier
                self.className = ResumeMainDataCell.self as! DataCell
            }
        }
        
        
        struct WorkViewModel {
            var companyName: String?
            var duration: String?
            
            init(_ work: WorkStore) {
                companyName = work.companyName
                duration = (work.duration?.end?.toFormatString() ?? "") + " - " + (work.duration?.start?.toFormatString() ?? "")
            }
        }
        
        struct EducationViewModel {
            var className: String?
            var passingYear: String?
            var gpa: String?
            
            init(_ education: EducationStore) {
                className = education.className
                passingYear = education.passingYear
                gpa = education.gpa
            }
        }
        
        struct ProjectViewModel {
            var name: String?
            var teamSize: Int?
            var summary: String?
            var technology: String?
            var role: String?
            
            init(_ project: ProjectStore) {
                name = project.projectName
                teamSize = project.teamSize
                summary = project.summary
                technology = project.technology
                role = project.role
            }
        }
    }
}

