//
//  LoginVC.swift
//  ShopApp
//
//  Created by Hesham Salama on 3/4/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginVC: UIViewController {
    
    var backgroundColor = UIColor(red: 137.0/255, green: 49.0/255, blue: 255/255, alpha: 1.0)
    let checkInfo = CheckInfo()
    var logo: UIImageView!
    var emailTextField: FramedTextField!
    var passwordTextField: FramedTextField!
    var loginButton : UIButton!
    var signUpSwitch : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        addLogo()
        addLoginInput()
        addLoginButton()
        addSwitchSignUp()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func logInButtonClicked(sender: UIButton!) {
        let errorType = checkInfo.localCheckLoginInfo(email: emailTextField.text!, password: passwordTextField.text!)
        guard errorType == .noError else {
            showErrorAlert(title: "Login Error", message: errorType.rawValue)
            return
        }
        SVProgressHUD.show(withStatus: "Logging in...")
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] (_, error) in
            guard let self = self else { return }
            guard error == nil else {
                DispatchQueue.main.async {
                    self.showErrorAlert(title: "Login Error", message: error?.localizedDescription ?? "Please try again")
                    SVProgressHUD.dismiss()
                }
                return
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                UIApplication.shared.delegate?.window??.rootViewController = MainVC()
            }
        }
    }
    
    @objc func switchSignUpButtonClicked(sender: UIButton!) {
        print("sign up clicked")
        self.present(RegisterVC(), animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        print("LoginVC is destroyed.")
    }
}

extension LoginVC {
    
    func addLogo() {
        logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        let viewHeight = view.frame.size.height
        addLogoConstraints(viewHeight)
    }
    
    func addLoginInput() {
        emailTextField = FramedTextField()
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        passwordTextField = FramedTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        addEmailTextFieldConstraints()
        addPasswordTextFieldConstraints()
    }
    

    
    func addLoginButton() {
        loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .purple
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(logInButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        addLoginButtonConstraints()
    }
    
    func addSwitchSignUp() {
        signUpSwitch = UIButton()
        signUpSwitch.setTitle("Don't have an account? Sign up", for: .normal)
        signUpSwitch.backgroundColor = backgroundColor
        signUpSwitch.setTitleColor(.white, for: .normal)
        signUpSwitch.translatesAutoresizingMaskIntoConstraints = false
        signUpSwitch.addTarget(self, action: #selector(switchSignUpButtonClicked), for: .touchUpInside)
        view.addSubview(signUpSwitch)
        addSwitchSignUpConstraints()
    }
    
    fileprivate func addLogoConstraints(_ viewHeight: CGFloat) {
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeight / 4).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    fileprivate func addEmailTextFieldConstraints() {
        emailTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    fileprivate func addPasswordTextFieldConstraints() {
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    
    fileprivate func addLoginButtonConstraints() {
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func addSwitchSignUpConstraints() {
        signUpSwitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        signUpSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        signUpSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        signUpSwitch.heightAnchor.constraint(equalToConstant: 75).isActive = true
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
