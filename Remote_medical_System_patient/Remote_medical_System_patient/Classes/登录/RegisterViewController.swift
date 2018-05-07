//
//  RegisterViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    //MARK: -ui控件
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        registerBtn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
    }
    
}

//MARK: -事件处理函数
extension RegisterViewController{
    
    
    
    @objc private func registerClick(){
        guard let username = usernameTF!.text, !username.isEmpty else {
            alertView(title: "请输入手机号！")
            return
        }
        
        guard ValidateTools.shareInstance.PhoneNumberIsValidated(vStr: username) else {
            alertView(title: "请输入正确的手机号！")
            return
        }
        
        
        guard let msgCode = messageTF!.text, !msgCode.isEmpty else {
            alertView(title: "请输入验证码！")
            return
        }
        
        guard ValidateTools.shareInstance.MessageIsValidated(vStr: msgCode) else {
            alertView(title: "请输入6位数字验证码！")
            return
        }
        
        
        guard let password = passwordTF!.text , !password.isEmpty else {
            alertView(title: "请输入密码！")
            return
        }
        guard ValidateTools.shareInstance.PasswordIsValidated(vStr: password) else {
            alertView(title: "请输入6位以上的密码！")
            return
        }
        
        
        register(cellphone: username, msgCode: msgCode, password:password) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code == "510" {
                    self.alertView(title: "用户不存在，请先注册！")
                    return
                }else if code == "502" {
                    self.alertView(title: "用户验证失败！")
                    return
                }
            }
            
            if let dateDic = result!["data"] {
                User.shareInstance.accesstoken = dateDic!["accesstoken"] as? String
                User.shareInstance.userid = dateDic!["userid"] as? String
                User.shareInstance.userType = dateDic!["userType"] as? String
            }
            let toast = ToastView()
            toast.showToast(text: "注册成功，请先完善您的信息", pos: .Mid)
            
            let sb = UIStoryboard(name: "login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "InformationVC") as! InformationViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
    }
    
    @objc public override func actionSendMessage(){
        
        guard let username = usernameTF!.text, !username.isEmpty else {
            alertView(title: "请输入手机号！")
            return
        }
        
        guard ValidateTools.shareInstance.PhoneNumberIsValidated(vStr: username) else {
            alertView(title: "请输入正确的手机号！")
            return
        }
        
        sendMeesage(cellphone: username) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code == "500" {
                    self.alertView(title: "获取验证码失败！")
                    return
                }
            }
            
        }
    }
}

//MARK: -网络请求函数
extension RegisterViewController{
    func register(cellphone : String , msgCode : String, password : String, finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/shiro/registeraccount"
        
        // 2.获取请求的参数
        let parameters = ["cellphone" : cellphone , "msgCode" : msgCode , "password" : password, "userType" : "doctor"]
        
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


