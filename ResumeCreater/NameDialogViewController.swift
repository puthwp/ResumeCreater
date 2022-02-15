//
//  NameDialogViewController.swift
//  ResumeCreater
//
//  Created by Sitthorn Ch on 15/2/2565 BE.
//

import Foundation
import UIKit

protocol NameDialogDelegate: class {
    func didSelecteSaveInDialog(_ dialog: NameDialogViewController?,firstname: String, lastname: String)
    func didSelectCloseInDialog(_ dialog: NameDialogViewController?)
}

class NameDialogViewController: UIViewController {
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: NameDialogDelegate?
    
    override func viewDidLoad(){
        
    }
    @IBAction func didSelectSaveAction(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            let firstname = self?.firstnameTextField.text ?? ""
            let lastname = self?.lastnameTextField.text ?? ""
            self?.delegate?.didSelecteSaveInDialog(self, firstname: firstname, lastname: lastname)
        }
    }
    @IBAction func didSelectCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.didSelectCloseInDialog(self)
        }
    }
}
