//
//  ResumeListViewController.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI

protocol ResumeListDisplayLogic: AnyObject {
    func displayAllResume(viewModel: ResumeList.ViewModel)
    func displayNameDidSaved(viewModel: ResumeList.ViewModel)
}

class ResumeListViewController: UICollectionViewController {
    
    var resumeItems: [ResumeList.ViewModel.item]?

    var interactor: ResumeListBusinessLogic?
    var router: (NSObjectProtocol & ResumeListRoutingLogic & ResumeListDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ResumeListInteractor()
        let presenter = ResumeListPresenter()
        let router = ResumeListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        passingDataStore(segue: segue)
    }
    
    func passingDataStore(segue: UIStoryboardSegue) {
        switch segue.identifier {
        case ResumeList.namingResumeSegue:
            let destinationVC = segue.destination as! NameDialogViewController
            destinationVC.delegate = self
        case ResumeList.newResumeSegue:
            let destinationVC = segue.destination as! ResumeMainViewController
            var destinationDataStore = destinationVC.router?.dataStore
            destinationDataStore?.firstname = self.router?.dataStore?.firstname
            destinationDataStore?.lastname = self.router?.dataStore?.lastname
        case ResumeList.editResumeSegue:
            let destinationVC = segue.destination as! ResumeMainViewController
            var destinationDataStore = destinationVC.router?.dataStore
            destinationDataStore?.resumeInfo = Resume()
        default:
            ()
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Resume List"
    }
}

extension ResumeListViewController: ResumeListDisplayLogic {
    func displayAllResume(viewModel:ResumeList.ViewModel) {
        self.resumeItems = viewModel.items
        self.collectionView.reloadData()
    }
    
    func displayNameDidSaved(viewModel: ResumeList.ViewModel) {
        self.performSegue(withIdentifier: ResumeList.newResumeSegue, sender: self)
    }
}

extension ResumeListViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeNameNewResume()
    }
}

extension ResumeListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (resumeItems?.count ?? 0) + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeItemListCell.identifier, for: indexPath) as? ResumeItemListCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5.0
        cell.layer.borderColor = .init(gray: 0.8, alpha: 0.3)
        cell.layer.borderWidth = 2.0
        cell.backgroundView?.backgroundColor = .quaternaryLabel
        return cell
    }
}

extension ResumeListViewController: NameDialogDelegate {
    func didSelecteSaveInDialog(_ dialog: NameDialogViewController?, firstname: String, lastname: String) {
        self.interactor?.saveName(firstname: firstname, lastname: lastname)
    }
    
    func didSelectCloseInDialog(_ dialog: NameDialogViewController?) {
        print("Closed Dialog")
    }
}


