//
//  ModifierViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/26.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class ModifierViewController: BaseViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var sureBtn: UIButton!
    
    var username : String?
    var phone : String?
    var email : String?
    
    
    override func viewDidLoad() {
        InitUI()
        super.viewDidLoad()
        sureBtn.addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    private func InitUI(){
        if username != nil , !(username?.isEmpty)! {
            phoneLabel.text = "用户名"
            phoneTF.text = username
        }
        if phone != nil , !(phone?.isEmpty)! {
            phoneLabel.text = "手机"
            phoneTF.text = phone
        }
        if email != nil , !(email?.isEmpty)! {
            phoneLabel.text = "邮箱"
            phoneTF.text = email
        }
        
    }
}

extension ModifierViewController{
    @objc private func onClick(){
        if username != nil {
            username = phoneTF.text
        }
        if phone != nil {
            phone = phoneTF.text
        }
        if email != nil {
            email = phoneTF.text
        }
        modifie(id: User.shareInstance.userid, cellphone: phone, email: email, realName: username, icon: nil) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code != "200" {
                    self.alertView(title: "操作失败，请检查网络连接！")
                    return
                }
            }
            let toast = ToastView()
            toast.showToast(text: "修改成功", pos: .Mid)
            if self.username != nil {
                User.shareInstance.username = self.username
            }
            if self.phone != nil {
                User.shareInstance.cellphone = self.phone
            }
            if self.email != nil {
                User.shareInstance.email = self.email
            }
            self.dismiss(animated: true, completion: nil)
            
        }
    }
}

extension ModifierViewController {
    private func modifie(id : String? ,cellphone : String? , email : String? , realName : String? , icon : String? , finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()){
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/doctor/updatedoctorbasemsg"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["id" : id , "cellphone" : cellphone , "email" : email ,"userName" : realName , "icon" : icon ]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.POST.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : [String : Any]?] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
}

