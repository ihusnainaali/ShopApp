//
//  CheckInfo.swift
//  ShopApp
//
//  Created by Hesham Salama on 3/6/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import Foundation

struct CheckInfo {
    enum errorType: String {
        case emptyPassword = "No password entered"
        case emptyEmail = "No email entered"
        case emptyName = "No name entered"
        case emptyAddress = "No address entered"
        case confirmPasswordMismatch = "The passwords don't match"
        case shortPassword = "Password is too short"
        case invalidEmail = "Invalid Email"
        case noError
    }
    
    func localCheckLoginInfo(email:String, password: String) -> errorType {
        guard email.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            return .emptyEmail
        }
        guard password.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            return .emptyPassword
        }
        guard password.count >= 6 else {
            return .shortPassword
        }
        guard email.isEmail() else {
            return .invalidEmail
        }
        return .noError
    }
    
    func localCheckSignUpInfo(email: String, password: String, confirmPassword: String, name: String, address: String) -> errorType {
        let error = localCheckLoginInfo(email: email, password: password)
        guard error == .noError else {
            return error
        }
        guard name.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            return .emptyName
        }
        guard address.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            return .emptyAddress
        }
        guard password == confirmPassword else {
            return .confirmPasswordMismatch
        }
        return .noError
    }
}

extension String {
    func isEmail() -> Bool {
        let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
        let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)
        return __emailPredicate.evaluate(with: self)
    }
}
