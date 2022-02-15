//
//  ResumeMainRouter.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ResumeMainRoutingLogic {}

protocol ResumeMainDataPassing {
    var dataStore: ResumeMainDataStore? { get }
}

class ResumeMainRouter: NSObject, ResumeMainRoutingLogic, ResumeMainDataPassing {
    weak var viewController: ResumeMainViewController?
    var dataStore: ResumeMainDataStore?
}
