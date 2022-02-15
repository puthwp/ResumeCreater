//
//  ResumeMainPresenter.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeMainPresentationLogic {
    func presentResumeProfile(response: ResumeMain.Response)
}

class ResumeMainPresenter: ResumeMainPresentationLogic {
    weak var viewController: ResumeMainDisplayLogic?
    func presentResumeProfile(response: ResumeMain.Response) {
        let viewModel = ResumeMain.ViewModel()
        viewController.displayResumeProfile(viewModel: viewModel)
    }
}
