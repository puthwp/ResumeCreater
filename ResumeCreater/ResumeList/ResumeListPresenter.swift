//
//  ResumeListPresenter.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeListPresentationLogic {
    func presentAllResume(response: ResumeList.Response)
    func presentNameDidSaved()
}

class ResumeListPresenter: ResumeListPresentationLogic {
    weak var viewController: ResumeListDisplayLogic?
    func presentAllResume(response: ResumeList.Response) {
        var viewModel = ResumeList.ViewModel()
//        viewModel.items = response.items.compactMap { ResumeList.ViewModel.item($0) }
        viewController?.displayAllResume(viewModel: viewModel)
    }
    
    func presentNameDidSaved() {
        let viewModel = ResumeList.ViewModel()
        viewController?.displayNameDidSaved(viewModel: viewModel)
    }
}
