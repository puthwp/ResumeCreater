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
    func displayErrorMsg(viewModel: ResumeMain.ViewModel)
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
    
    var imagePicker = UIImagePickerController()
    
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
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.layoutSetup()
        self.interactor?.fetchResumeProfile()
    }
    
    func layoutSetup() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileWrapper.layer.cornerRadius = self.profileWrapper.bounds.width / 2
    }
    
    @IBAction func editProfilePhoto(_ sender: UITapGestureRecognizer) {
        self.present(imagePicker, animated: true) {
            
        }
    }
    @IBAction func editNameHandler(_ sender: UIButton) {
    }
}

extension ResumeMainViewController: ResumeMainDisplayLogic {
    func displayResumeProfile(viewModel: ResumeMain.ViewModel) {
        firstnameLabel.text = viewModel.firstname
        lastNameLabel.text = viewModel.lastname
    }
    
    func displayErrorMsg(viewModel: ResumeMain.ViewModel) {
        let alertView = UIAlertController(title: "Error...", message: viewModel.errorMsg, preferredStyle: .alert)
        self.presentingViewController?.dismiss(animated: false, completion: {
            self.present(alertView, animated: true) {
                
            }
        })
    }
}

extension ResumeMainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = image
            picker.dismiss(animated: true) {
                //
                 image.saveToDocumentFolder()
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
        picker.dismiss(animated: true) {
            //
        }
    }
}

extension UIImage {
    var documentDirectory: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    func saveToDocumentFolder() -> String {
        if let data = self.pngData() {
            guard let pathURL = documentDirectory?.appendingPathComponent("\(UUID().uuidString).png") else {
                return ""
            }
            try? data.write(to: pathURL)
            return pathURL.absoluteString
        }
        return ""
    }
}
