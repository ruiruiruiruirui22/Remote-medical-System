//
//  Meeting.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/29.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import Foundation
class Meeting : NSObject {
     var id : Int?
     var name : String?
     var cellphone : String?
     var sex : String?
     var ismarry : String?
     var birthday : String?
     var occupation : String?
     var medicalHistory : String?
     var disasterDescription : String?
     var isHospital : String?
     var operationDescription : String?
     var traumaDescription : String?
     var chronicDescription: String?
     var participateId : String?
     var meetingTime : String?
     var meetingType : String?
     var applyTime : String?
     var decomPicture : String?
     var manageId : String?
     var state : Int?
     var roomId : String?
    
    override init() {}
    static let shareInstance: Meeting={
        let meeting=Meeting();
        return meeting
    }()
   
    
    init(dict : [String : Any]){
       id = dict["id"] as? Int
       meetingTime = dict["meetingTime"] as? String
       applyTime =  dict["applyTime"] as? String
       meetingType =  dict["meetingType"] as? String
      disasterDescription =  dict["disasterDescription"] as? String
      state =  dict["state"] as? Int
        name =  dict["name"] as? String
    
       cellphone =  dict["cellphone"] as? String
       sex =  dict["sex"] as? String
        ismarry =  dict["ismarry"] as? String
        birthday =  dict["birthday"] as? String
        occupation =  dict["occupation"] as? String
        medicalHistory =  dict["medicalHistory"] as? String
        isHospital =  dict["isHospital"] as? String
        operationDescription =  dict["operationDescription"] as? String
         traumaDescription =  dict["traumaDescription"] as? String
         chronicDescription =  dict["chronicDescription"] as? String
        roomId =  dict["roomId"] as? String
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
