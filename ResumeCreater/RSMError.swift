//
//  RSMError.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 16/2/2565 BE.
//

import Foundation
enum RSMError: Error {
    case fetchedError
    case somethingwrong
    case savedError
    case urlNotFound
    
    var localizedDescription: String {
        switch self {
        case .fetchedError:
            return "Cannot Fetch Infomation right now, Please try again later."
        case .somethingwrong:
            return "Something went wrong, Please try again"
        case .savedError:
            return "Cannot Save Info right now, Please try again."
        case .urlNotFound:
            return "The Requested url is not found"
        }
    }
}
