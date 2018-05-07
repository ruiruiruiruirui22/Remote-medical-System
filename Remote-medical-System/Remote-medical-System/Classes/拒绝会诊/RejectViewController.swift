//
//  RejectViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/27.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class RejectViewController: BaseViewController {

    @IBOutlet weak var oneBtn: UIButton!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var reasonTF: UITextField!
    @IBOutlet weak var sureBtn: UIButton!
    lazy var reject : String? = ""
    var meeting_id : Int?
    var doctor_id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
    }
}


extension RejectViewController{
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            oneBtn.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
            twoBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            threeBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            fourBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            reasonTF.isEnabled = false
            reject = "没有时间"
        case 2:
            oneBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            twoBtn.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
            threeBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            fourBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            reasonTF.isEnabled = false
            reject = "不属于自己的专业"
        case 3:
            oneBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            twoBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            threeBtn.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
            fourBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            reasonTF.isEnabled = false
            reject = "资料不完善，无法做出决定"
        default:
            oneBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            twoBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            threeBtn.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            fourBtn.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
            reasonTF.isEnabled = true
        }
    }
    
    @objc private func sureBtnClick(){
        if reasonTF.isEnabled {
            reject = reasonTF.text
        }
        rejectMeeting(meeting_id: meeting_id!, doctor_id: doctor_id!, reason: reject!)
    }
}


extension RejectViewController {
    private func rejectMeeting(meeting_id : Int, doctor_id : String , reason : String?) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/handlemeeting"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["meeting_id" : meeting_id , "doctor_id" : doctor_id , "operation" : 0 , "reason" : reject] as [String : Any]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
                guard let resultDic = result as? [String : Any] else{
                    self.alertView(title: "网络请求失败")
                    return
                }
                
                guard let dateArray = resultDic["result"] as? [String:Any] else {
                    return
                }
                
                guard let code = dateArray["code"] as? String else {
                    return
                }
                
                if code == "200"  {
                    let toast = ToastView()
                    toast.showToast(text: "操作成功", pos: .Mid)
                }else if code == "500"{
                    let toast = ToastView()
                    toast.showToast(text: "操作成功", pos: .Mid)
                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
}
}
