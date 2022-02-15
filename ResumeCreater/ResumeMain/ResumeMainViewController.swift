//
//  ResumeMainViewController.swift
//  ResumeCreater
//
//  Created by Thinnaphat Ch on 13/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ResumeMainDisplayLogic: AnyObject {
    func displayResumeProfile(viewModel: ResumeMain.ViewModel)
}

class ResumeMainViewController: UITableViewController {
    static let segueIdentifier: String = "NewResumeSegue"
    // @IBOutlet var

    @IBOutlet weak var profileWrapper: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var editNameButton: UIButton!
    var interactor: ResumeMainBusinessLogic?
    var router: (NSObjectProtocol & ResumeMainRoutingLogic & ResumeMainDataPassing)?

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
        let interactor = ResumeMainInteractor()
        let presenter = ResumeMainPresenter()
        let router = ResumeMainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.layoutSetup()
    }
    
    func layoutSetup() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileWrapper.layer.cornerRadius = self.profileWrapper.bounds.width / 2
    }
    
    @IBAction func editProfilePhoto(_ sender: UITapGestureRecognizer) {
    }
    @IBAction func editNameHandler(_ sender: UIButton) {
    }
}

extension ResumeMainViewController: ResumeMainDisplayLogic {
    func displayResumeProfile(viewModel: ResumeMain.ViewModel) {
        //
    }
}


extension ResumeMainViewController {
    
}
