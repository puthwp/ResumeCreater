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
    func displayMsg(viewModel: ResumeMain.ViewModel)
}

class ResumeMainViewController: UITableViewController {
    static let segueIdentifier: String = "NewResumeSegue"
    // @IBOutlet var
    var displayItems: [[ResumeMain.ViewModel.DisplayModel]]?

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
        self.present(imagePicker, animated: true,completion: nil)
    }
    @IBAction func editNameHandler(_ sender: UIButton) {
    }
}

extension ResumeMainViewController: ResumeMainDisplayLogic {
    func displayResumeProfile(viewModel: ResumeMain.ViewModel) {
        firstnameLabel.text = viewModel.firstname
        lastNameLabel.text = viewModel.lastname
        profileImageView.image = viewModel.profileImage
    }
    
    func displayMsg(viewModel: ResumeMain.ViewModel) {
        let alertView = UIAlertController(title: "Messege", message: viewModel.msg, preferredStyle: .alert)
        self.presentingViewController?.dismiss(animated: false, completion: {
            self.present(alertView, animated: true) {
                
            }
        })
    }
}

extension ResumeMainViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ResumeMain.display.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ResumeMain.display[section].count
        default:
            return (displayItems?[section].count ?? 0) + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Education"
        case 2:
            return "Work"
        case 3:
            return "Projects"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResumeMainDataCell.identifier, for: indexPath) as? ResumeMainDataCell else {
                return UITableViewCell()
            }
            cell.viewModel = displayItems?[indexPath.section][indexPath.row]
            return cell
        default:
            if indexPath.row == displayItems?.count ?? 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ResumeMainDataAddCell.identifier, for: indexPath) as! ResumeMainDataAddCell
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResumeMainDataCell.identifier, for: indexPath) as? ResumeMainDataCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

extension ResumeMainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = image
            picker.dismiss(animated: true) {
                //
                 let url = image.saveToDocumentFolder()
                var request = ResumeMain.Request()
                request.profileImage = url
                self.interactor?.saveResumeObject(request: request)
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
    func saveToDocumentFolder() -> String {
        if let data = self.pngData() {
            let fileName = "\(UUID().uuidString).png"
            guard let pathURL = FileManager.documentPath?.appendingPathComponent(fileName) else {
                return ""
            }
            try? data.write(to: pathURL)
            return fileName
        }
        return ""
    }
}

extension FileManager {
    static var documentPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
