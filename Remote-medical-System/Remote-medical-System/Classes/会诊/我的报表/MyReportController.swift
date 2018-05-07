//
//  MyReportController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/17.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class MyReportController: BaseViewController {

    @IBOutlet weak var allApply: UILabel!
    @IBOutlet weak var normalApply: UILabel!
    @IBOutlet weak var videoApply: UILabel!
    @IBOutlet weak var allApplyed: UILabel!
    @IBOutlet weak var normalApplyed: UILabel!
    @IBOutlet weak var videoApplyed: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitUI()
    }

  
    func InitUI(){
        loadCount0()
        loadCount1()
        loadCount2()
        loadCount3()
        loadCount4()
        loadCount5()
    }
}

//MARK: -网络请求函数
extension MyReportController{
    func loadCount(doctor_id : String , isApply : Int , type : String ,  finished : @escaping (_ result : [String : Any]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/getapplycount"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        var  parameters = ["doctor_id" : doctor_id, "isApply" : isApply] as [String : Any]
        if !type.isEmpty {
            parameters["type"] = type
        }
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
    
    func loadCount0(){
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 1, type: "") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.allApply.text = String(count!)
            
        }
    }
    
    func loadCount1() {
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 1, type: "普通") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.normalApply.text = String(count!)
        }
   }
    
    func loadCount2() {
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 1, type: "视频") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.videoApply.text = String(count!)

        }
    }

    func loadCount3() {
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 0, type: "") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.allApplyed.text = String(count!)

        }
    }

    func loadCount4() {
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 0, type: "普通") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.normalApplyed.text = String(count!)
        }
    }

    func loadCount5() {
        loadCount(doctor_id: User.shareInstance.userid!, isApply: 0, type: "视频") { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            let count = result!["data"] as? Int
            self.videoApplyed.text = String(count!)

        }
    }

    
}
