//
//  MeetingModel.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/9.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import Foundation
class MeetingModel : NSObject{
    var applyDoctor : Doctor
    lazy var applyedDoctors : [Doctor] = [Doctor]()
    var meeting : Meeting
    var result : Result?
  
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    init(dict : [String : Any]){
       
        self.applyDoctor = Doctor(dict: dict["applyDoctor"] as! [String : Any])
        self.meeting = Meeting(dict:dict["meeting"] as! [String : Any])
        if let resultdic =  dict["meetingResult"] as? [String : Any] {
             self.result = Result(dict:resultdic)
        }
        super.init()
        guard let array =  dict["applyedDoctors"]  as? [[String : Any]] else {
            return
        }
        for doctorDic in array {
         let applyedDoctor = Doctor(dict: doctorDic)
         self.applyedDoctors.append(applyedDoctor)
        }
        
        
       
    }
}

