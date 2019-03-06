//
//  RegisterVC.swift
//  ShopApp
//
//  Created by Hesham Salama on 3/4/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class RegisterVC: UIViewController {

    var backgroundColor = UIColor(red: 137.0/255, green: 49.0/255, blue: 255/255, alpha: 1.0)
    let checkInfo = CheckInfo()
    var logo: UIImageView!
    var nameTextField: FramedTextField!
    var addressTextField: FramedTextField!
    var emailTextField: FramedTextField!
    var passwordTextField: FramedTextField!
    var confirmPasswordTextField: FramedTextField!
    var signUpButton : UIButton!
    var logInSwitchButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        addViews()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func signUpButtonClicked(sender: UIButton!) {
        let errorType = checkInfo.localCheckSignUpInfo(email: emailTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!, name: nameTextField.text!, address: addressTextField.text!)
        guard errorType == .noError else {
            showErrorAlert(title: "Sign up Error", message: errorType.rawValue)
            return
        }
        SVProgressHUD.show(withStatus: "Signing up...")
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (_, error) in
            guard let self = self else { return }
            guard error == nil else {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.showErrorAlert(title: "Sign up Error", message: error?.localizedDescription ?? "Please try again")
                }
                return
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                UIApplication.shared.delegate?.window??.rootViewController = MainVC()
            }
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func switchLogInButtonClicked(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("RegisterVC is destroyed.")
    }
}

extension RegisterVC {
    
    func addViews() {
        addLogo()
        addNameTextField()
        addAddressTextField()
        addEmailTextField()
        addPasswordTextField()
        addConfirmPasswordTextField()
        addSignUpButton()
        addLogInSwitchButton()
    }
    
    func addLogo() {
        logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        let viewHeight = view.frame.size.height
        addLogoConstraints(viewHeight)
    }
    
    func addNameTextField() {
        nameTextField = FramedTextField()
        nameTextField.placeholder = "Name"
        view.addSubview(nameTextField)
        addNameTextFieldConstraints()
    }
    
    func addAddressTextField() {
        addressTextField = FramedTextField()
        addressTextField.placeholder = "Address"
        view.addSubview(addressTextField)
        addAddressTextFieldConstraints()
    }
    
    func addEmailTextField() {
        emailTextField = FramedTextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
        addEmailTextFieldConstraints()
    }
    
    func addPasswordTextField() {
        passwordTextField = FramedTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        addPasswordTextFieldConstraints()
    }
    
    func addConfirmPasswordTextField() {
        confirmPasswordTextField = FramedTextField()
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.isSecureTextEntry = true
        view.addSubview(confirmPasswordTextField)
        addConfirmPasswordTextFieldConstraints()
    }
    
    func addSignUpButton() {
        signUpButton = UIButton()
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = .purple
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signUpButton)
        addSignUpButtonConstraints()
    }
    
    func addLogInSwitchButton() {
        logInSwitchButton = UIButton()
        logInSwitchButton.setTitle("Already have an account? Sign in", for: .normal)
        logInSwitchButton.backgroundColor = backgroundColor
        logInSwitchButton.setTitleColor(.white, for: .normal)
        logInSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        logInSwitchButton.addTarget(self, action: #selector(switchLogInButtonClicked), for: .touchUpInside)
        view.addSubview(logInSwitchButton)
        addLogInSwitchButtonConstraints()
    }
    
    fileprivate func addLogoConstraints(_ viewHeight: CGFloat) {
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeight / 10).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func addNameTextFieldConstraints() {
        nameTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func addAddressTextFieldConstraints() {
        addressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8).isActive = true
        addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func addEmailTextFieldConstraints() {
        emailTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 8).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func addPasswordTextFieldConstraints() {
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func addConfirmPasswordTextFieldConstraints() {
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func addSignUpButtonConstraints() {
        signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 16).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addLogInSwitchButtonConstraints() {
        logInSwitchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        logInSwitchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        logInSwitchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        logInSwitchButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
