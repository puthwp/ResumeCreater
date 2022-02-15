//
//  ResumeListViewController.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI

protocol ResumeListDisplayLogic: AnyObject {
    func displayAllResume(viewModel: ResumeList.ViewModel)
    func displayNameDidSaved(viewModel: ResumeList.ViewModel)
    func displayErrorMsg(viewModel: ResumeList.ViewModel)
    func displayDidSelectedItem()
}

class ResumeListViewController: UICollectionViewController {
    
    var resumeItems: [ResumeList.ViewModel.Item]?

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
            destinationVC.isModalInPresentation = true
            destinationVC.delegate = self
        case ResumeList.newResumeSegue:
            let destinationVC = segue.destination as! ResumeMainViewController
            var destinationDataStore = destinationVC.router?.dataStore
            destinationDataStore?.resumeID = self.router?.dataStore?.resumeID
        case ResumeList.editResumeSegue:
            let destinationVC = segue.destination as! ResumeMainViewController
            var destinationDataStore = destinationVC.router?.dataStore
<<<<<<< HEAD
            destinationDataStore?.resumeID = self.router?.dataStore?.resumeID
=======
            destinationDataStore?.resumeInfo = ResumeStore()
>>>>>>> a32b61646be03a0b07987d4d9d7901012e3ab112
        default:
            ()
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Resume List"
        self.interactor?.fetchAllResumes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
}

extension ResumeListViewController: ResumeListDisplayLogic {
    func displayErrorMsg(viewModel: ResumeList.ViewModel) {
        let alertBox = UIAlertController(title: "Error", message: viewModel.errorMsg, preferredStyle: .alert)
        self.presentingViewController?.dismiss(animated: true, completion: {
            self.present(alertBox, animated: true) {
                
            }
        })
    }
    
    func displayAllResume(viewModel:ResumeList.ViewModel) {
        self.resumeItems = viewModel.items
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
    }
    
    func displayNameDidSaved(viewModel: ResumeList.ViewModel) {
        self.performSegue(withIdentifier: ResumeList.newResumeSegue, sender: self)
    }
    
    func displayDidSelectedItem() {
        self.performSegue(withIdentifier: ResumeList.editResumeSegue, sender: self)
    }
}

extension ResumeListViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < resumeItems?.count ?? 0 else {
            router?.routeNameNewResume()
            return
        }
        interactor?.didSelectedItem(resumeItems?[indexPath.row])
    }
}

extension ResumeListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (resumeItems?.count ?? 0) + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard self.resumeItems?.count == indexPath.row else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeItemCollectionCell.identifier, for: indexPath) as! ResumeItemCollectionCell
            cell.setData(resumeItems?[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResumeAddItemCollectionCell.identifier, for: indexPath) as? ResumeAddItemCollectionCell else {
            return UICollectionViewCell()
        }
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


