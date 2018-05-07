//
//  User.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import Foundation

class User:NSObject {
    
    var accesstoken : String?
    var userid : String?
    var userType : String?
    var cellphone : String?
    var department : String?
    var email : String?
    var hospital : String?
    var icon : String?
    var prositionalTitle : String?
    var realName : String?
    var username : String?
    
    override init() {}
    static let shareInstance: User={
        let user=User();
        return user
    }()
    init(dict : [String : Any]){
        accesstoken = dict["accesstoken"] as? String
        userid = dict["userid"] as? String
        userType = dict["userType"] as? String
        cellphone = dict["cellphone"] as? String
        department = dict["department"] as? String
        email = dict["email"] as? String
        hospital = dict["hospital"] as? String
        icon = dict["icon"] as? String
        prositionalTitle = dict["prositionalTitle"] as? String
        realName = dict["realName"] as? String
        username = dict["username"] as? String
    }
    
    static func reset(){
        User.shareInstance.accesstoken = nil
        User.shareInstance.userid = nil
        User.shareInstance.userType = nil
        User.shareInstance.cellphone  = nil
        User.shareInstance.department = nil
        User.shareInstance.email  = nil
        User.shareInstance.hospital = nil
        User.shareInstance.icon  = nil
        User.shareInstance.prositionalTitle = nil
        User.shareInstance.realName  = nil
        User.shareInstance.username  = nil
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

