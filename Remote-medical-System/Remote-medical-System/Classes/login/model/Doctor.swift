//
//  User.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import Foundation

class Doctor:NSObject {
    var hospital : String?
    var department : String?
    var realName : String?
    var cellphone : String?
    var id : String?
    var icon : String?
    var email : String?
    var isSelect : Bool = false
    init(dict : [String : Any]){
        hospital = dict["hospital"] as? String
        department = dict["department"] as? String
        realName = dict["realName"] as? String
        cellphone = dict["cellphone"] as? String
        id = dict["id"] as? String
        icon = dict["icon"] as? String
        email = dict["email"] as? String
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
