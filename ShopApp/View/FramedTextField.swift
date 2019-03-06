//
//  EventTextField.swift
//  EventCountdown
//
//  Created by Hesham Salama on 2/25/19.
//  Copyright © 2019 hesham. All rights reserved.
//

import UIKit

class FramedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 137.0/255, green: 128.0/255, blue: 255.0/255, alpha: 1.0)
        textAlignment = .left
        layer.cornerRadius = 15.0
        font = UIFont.systemFont(ofSize: 20)
        textColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
