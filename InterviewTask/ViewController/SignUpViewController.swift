//
//  ViewController.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var keepTheGlowLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var validateInfoLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var param = RequestUserAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureUI()
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
    
    func isValidData() -> Bool {
        if !(emailTextField.text?.isValidEmail() ?? false) || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            emailTextField.becomeFirstResponder()
            validateInfoLabel.text = "enter valid email"
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
    
    @IBAction func SignUpButtonAction(_ sender: UIButton) {
        if isValidData() {
            
            DataContainer.sharedInstance.postAuth(with: param) { (loggedIn, response, error) in
                print(response)
                if loggedIn {
                    let alert = UIAlertController(title: "log in ", message: nil, preferredStyle: .actionSheet)
                    self.show(alert, sender: nil)
                } else {
                    let alert = UIAlertController(title: " does not register ", message: nil, preferredStyle: .actionSheet)
                                       self.show(alert, sender: nil)
                }
            }
        }
    }
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
        print("sign in")
    }
    func configureTextField() {
        nameTextField.setPlaceholder(text: "Name", color: UIColor.textFieldColor)
        emailTextField.setPlaceholder(text: "Email", color:  UIColor.textFieldColor)
        passwordTextField.setPlaceholder(text: "Password", color: UIColor.textFieldColor)
        phoneTextField.setPlaceholder(text: "Phone number", color:  UIColor.textFieldColor)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    func configureUI() {
        let gradient = CAGradientLayer.getGradientLayer(bounds: keepTheGlowLabel.bounds)
        keepTheGlowLabel.textColor = UIColor.gradientColor(bounds: keepTheGlowLabel.bounds, gradientLayer: gradient)
    }
    
    func addTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Keyboard
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWasShow(aNotification: Notification) {
        guard let keyboardFrameValue = aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func keyboardWillBeHidden(aNotification: Notification){
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

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
