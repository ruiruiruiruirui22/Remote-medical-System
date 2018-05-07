//
//  UITextField-extension.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/25.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit
extension UITextField{
    convenience init(name : String) {
        self.init()
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.masksToBounds = true
        
        let label = UILabel()
        label.text = name
        label.textColor = UIColor.green
        self.leftView = label
        sizeToFit()
    }
}
