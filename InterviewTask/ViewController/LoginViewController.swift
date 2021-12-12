//
//  LoginViewController.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/12/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    func configureTextField() {
        emailTextField.setPlaceholder(text: "Email", color: .textFieldColor)
        passwordTextField.setPlaceholder(text: "Password", color: .textFieldColor)
    }
    
    @IBAction func openRegisterPageAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController")
//        present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        
    }
}
