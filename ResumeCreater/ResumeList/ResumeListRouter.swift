//
//  ResumeListRouter.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ResumeListRoutingLogic {
    func routeNameNewResume()
    func routeToCreateNewResume()
    func routeToEditResume()
}

protocol ResumeListDataPassing {
    var dataStore: ResumeListDataStore? { get }
}

class ResumeListRouter: NSObject, ResumeListRoutingLogic, ResumeListDataPassing {
    weak var viewController: ResumeListViewController?
    var dataStore: ResumeListDataStore?
    
    func routeNameNewResume() {
        viewController?.performSegue(withIdentifier: ResumeList.namingResumeSegue,
                                     sender: self)
    }
    
    func routeToCreateNewResume() {
        viewController?.performSegue(withIdentifier: ResumeList.newResumeSegue, sender: self)
    }
    
    func routeToEditResume() {
        viewController?.performSegue(withIdentifier: ResumeList.editResumeSegue, sender: self)
    }
}
