//
//  LoginViewController.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/12/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var passwordTextField: TextField!
    @IBOutlet private weak var emailTextField: TextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var param = RequestUserAccount()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeForKeyboardNotifications()
    }
    
    // MARK: - Methods
    private func configureTextField() {
        emailTextField.setPlaceholder(text: "Email", color: .textFieldColor)
        passwordTextField.setPlaceholder(text: "Password", color: .textFieldColor)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.show(alert, sender: nil)
    }
    
    private func isValidData() -> Bool {
        if !(emailTextField.text?.isValidEmail() ?? false) || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            emailTextField.becomeFirstResponder()
            return false
        }
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            passwordTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction private func openRegisterPageAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController")
//        present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - IBActions
    @IBAction private func signInAction(_ sender: UIButton) {
        if isValidData() {
            activityIndicator.startAnimating()
            DataContainer.sharedInstance.login(with: param) { (response, user) in
                self.activityIndicator.stopAnimating()
                if response?.loggedIn  ?? false {
                    self.showAlert(text: "you are successfully logged in")
                }
                if response?.errors?[0] != nil, let err = response?.errors?[0] {
                    self.showAlert(text: err)
                }
                print(user ?? [:])
            }
        }
    }
    
    //MARK: - Keyboard
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShow(aNotification: Notification) {
        guard let keyboardFrameValue = aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func keyboardWillBeHidden(aNotification: Notification){
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            param.email = ""
        } else if textField == passwordTextField {
            param.password = ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            param.email = textField.text ?? ""
        } else if textField == passwordTextField {
            param.password = passwordTextField.text ?? ""
        }
    }
}
