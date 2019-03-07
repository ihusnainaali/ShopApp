//
//  DatabaseManager.swift
//  ShopApp
//
//  Created by Hesham Salama on 3/7/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    private let CUSTOMER_ROOT_KEY = "customer"
    private let NAME_KEY = "name"
    private let ADDRESS_KEY = "address"
    private let EMAIL_KEY = "email"
    private let DATE_ENTERED_KEY = "date_entered"
    private let LAST_LOGIN_KEY = "last_login"
    private let WISHLIST_ITEMS_KEY = "wishlist_items"
    private let CART_ITEMS_KEY = "cart_items"

    private var childID: String?
    static let shared = DatabaseManager()
    private init() {}
    
    func saveCustomerFirstSignUpInfo(name: String, address: String, email: String) {
        let customerRef = Database.database().reference(withPath: CUSTOMER_ROOT_KEY)
        let currentDate = getCurrentDate()
        let dict : [String : Any?] = [NAME_KEY:name, ADDRESS_KEY: address, EMAIL_KEY:email, DATE_ENTERED_KEY: currentDate, LAST_LOGIN_KEY: currentDate, WISHLIST_ITEMS_KEY:nil, CART_ITEMS_KEY:nil]
        let autoIDRef = customerRef.childByAutoId()
        childID = autoIDRef.key
        autoIDRef.setValue(dict)
    }
    
    func editLastLoginTime(forEmail email: String) {
        let customerRef = Database.database().reference(withPath: CUSTOMER_ROOT_KEY)
        customerRef.queryOrdered(byChild: EMAIL_KEY).queryEqual(toValue: email).observeSingleEvent(of: .value) { [weak self](snap : DataSnapshot) in
            guard let self = self else {return}
            let id = (snap.children.nextObject() as AnyObject).key as String
            self.childID = id
            snap.ref.child(id).updateChildValues([self.LAST_LOGIN_KEY:self.getCurrentDate()])
        }
    }
    
    private func getCurrentDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy hh:mm:ss"
        return df.string(from: Date())
    }
    
}
