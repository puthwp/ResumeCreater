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
<<<<<<< HEAD
    func presentError(response: ResumeMain.Response)
=======
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
}

class ResumeMainPresenter: ResumeMainPresentationLogic {
    weak var viewController: ResumeMainDisplayLogic?
    func presentResumeProfile(response: ResumeMain.Response) {
<<<<<<< HEAD
        let viewModel = ResumeMain.ViewModel(.init(value: response.resumeInfo!))
        viewController?.displayResumeProfile(viewModel: viewModel)
    }
    
    func presentError(response: ResumeMain.Response) {
        let viewModel = ResumeMain.ViewModel(response.error?.localizedDescription ?? "Unknow")
//        viewModel.errorMsg = response.error?.localizedDescription
        viewController?.displayErrorMsg(viewModel: viewModel)
=======
        let viewModel = ResumeMain.ViewModel()
        viewController.displayResumeProfile(viewModel: viewModel)
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
    }
}
