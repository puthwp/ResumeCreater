//
//  ResumeListPresenter.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeListPresentationLogic {
    func presentAllResume(response: ResumeList.Response)
    func presentError(response: ResumeList.Response)
    func presentDidSelectedItem()
    func presentNameDidSaved()
}

class ResumeListPresenter: ResumeListPresentationLogic {
    weak var viewController: ResumeListDisplayLogic?
    func presentAllResume(response: ResumeList.Response) {
        var viewModel = ResumeList.ViewModel()
        viewModel.items = response.items?.compactMap { ResumeList.ViewModel.Item($0) }
        viewController?.displayAllResume(viewModel: viewModel)
    }
    
    func presentError(response: ResumeList.Response) {
        var viewModel = ResumeList.ViewModel()
        viewModel.errorMsg = response.error?.localizedDescription
        viewController?.displayErrorMsg(viewModel: viewModel)
    }
    
    func presentDidSelectedItem() {
        viewController?.displayDidSelectedItem()
    }
    
    func presentNameDidSaved() {
        let viewModel = ResumeList.ViewModel()
        viewController?.displayNameDidSaved(viewModel: viewModel)
    }
}
