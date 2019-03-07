//
//  ViewController.swift
//  ShopApp
//
//  Created by Hesham Salama on 3/4/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if let email = Auth.auth().currentUser?.email {
            DatabaseManager.shared.editLastLoginTime(forEmail: email)
        } else {
            fatalError("NO_EMAIL_FOUND")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

}

