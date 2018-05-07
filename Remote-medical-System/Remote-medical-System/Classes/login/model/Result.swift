//
//  Result.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/12.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import Foundation

class Result:NSObject {
    
      var reject : String?
      var nexttime : String?
      var judge : String?
      var reason : String?
      var advise : String?
      var plan : String?
      var improve : String?
      var referral : String?
   
    init(dict : [String : Any]){
        reject = dict["reject"] as? String
        nexttime = dict["nexttime"] as? String
        judge = dict["judge"] as? String
        advise = dict["advise"] as? String
        reason = dict["reason"] as? String
        plan = dict["plan"] as? String
        improve = dict["improve"] as? String
        referral = dict["referral"] as? String

    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

