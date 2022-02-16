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
    func presentError(response: ResumeMain.Response)
    func presentSuccess(response: ResumeMain.Response)
}

class ResumeMainPresenter: ResumeMainPresentationLogic {
    weak var viewController: ResumeMainDisplayLogic?
    func presentResumeProfile(response: ResumeMain.Response) {
        let viewModel = ResumeMain.ViewModel(.init(value: response.resumeInfo!))
        viewController?.displayResumeProfile(viewModel: viewModel)
    }
    
    func presentError(response: ResumeMain.Response) {
        let viewModel = ResumeMain.ViewModel(response.error?.localizedDescription ?? "Unknow")
        viewController?.displayMsg(viewModel: viewModel)
    }
    
    func presentSuccess(response: ResumeMain.Response) {
        let viewModel = ResumeMain.ViewModel()
        viewController?.displayMsg(viewModel: viewModel)
    }
}
