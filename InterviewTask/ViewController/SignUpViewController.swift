//
//  ViewController.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var validateInfoLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private var param = RequestUserAccount()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        addTapToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeForKeyboardNotifications()
    }
    
    // MARK: - IBActions
    @IBAction private func SignUpButtonAction(_ sender: UIButton) {
        if isValidData() {
            activityIndicator.startAnimating()
            DataContainer.sharedInstance.register(with: param) { (loggedIn, response, sessionResponse) in
                self.activityIndicator.stopAnimating()
                if sessionResponse?.loggedIn ?? false {
                    let alert = self.showAlert(text: "you are successfully registered")
                    self.show(alert, sender: nil)
                } else if sessionResponse?.errors?[0] != nil{
                    let alert = self.showAlert(text: sessionResponse?.errors?[0] ?? "")
                    self.show(alert, sender: nil)
                }
            }
        }
    }
    @IBAction private func LoginButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Methods
    private func configureTextField() {
        nameTextField.setPlaceholder(text: "Name", color: UIColor.textFieldColor)
        emailTextField.setPlaceholder(text: "Email", color:  UIColor.textFieldColor)
        passwordTextField.setPlaceholder(text: "Password", color: UIColor.textFieldColor)
        phoneTextField.setPlaceholder(text: "Phone number", color:  UIColor.textFieldColor)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func isValidData() -> Bool {
        if !(emailTextField.text?.isValidEmail() ?? false) || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            emailTextField.becomeFirstResponder()
            validateInfoLabel.text = "Please enter a valid email"
            return false
        }
        if phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || (phoneTextField.text ?? "").count != 10 {
            validateInfoLabel.text = "Please enter a valid 10-digit phone number"
            phoneTextField.becomeFirstResponder()
            return false
        }
        if  !(passwordTextField.text?.isValidPassword() ?? false) || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            validateInfoLabel.text = "Password must be at least 8 characters."
            passwordTextField.becomeFirstResponder()
            return false
        }
        validateInfoLabel.text = ""
        return true
    }
    
    private func showAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    private func addTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField {
            param.name = ""
        } else if textField == emailTextField {
            param.email = ""
        } else if textField == phoneTextField {
            param.phone_number = ""
        } else if textField == passwordTextField {
            param.password = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            param.name = textField.text ?? ""
        } else if textField == emailTextField {
            param.email = textField.text ?? ""
        } else if textField == phoneTextField {
            param.phone_number = phoneTextField.text ?? ""
        } else {
            param.password = passwordTextField.text ?? ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            return string == string.filter("0123456789.".contains)
        }
        return true
    }
}
