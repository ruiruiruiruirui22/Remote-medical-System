//
//  ForgetViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class ForgetViewController: BaseViewController {
    
    //MARK：-ui控件
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var vertifyPasswordTF: UITextField!
    @IBOutlet weak var updatePasswordBtn: UIButton!
    
    //MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePasswordBtn.addTarget(self, action: #selector(updatePasswordBtnClick), for: .touchUpInside)
    }
}



//MARK: -事件处理函数
extension ForgetViewController {
    
    
    @objc  private func updatePasswordBtnClick(){
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
        
        guard let verifyPassword  = vertifyPasswordTF.text, !verifyPassword.isEmpty else{
            alertView(title: "请输入确认密码！")
            return
        }
        
        
        if verifyPassword != password {
            alertView(title: "密码与确认密码不一致！")
            return
        }
        
        updatePassword(cellphone: username, msgCode: msgCode, newPassword: password) { (result , error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code == "510" {
                    self.alertView(title: "用户不存在，请先注册！")
                    return
                }else if code == "500" {
                    self.alertView(title: "执行失败！")
                    return
                }else if code == "502" {
                    self.alertView(title: "用户验证失败！")
                    return
                }
            }
            let toast = ToastView()
            toast.showToast(text: "修改成功，请重新登录", pos: .Mid)
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
            
        }}
}
//MARK: -网络请求函数
extension ForgetViewController{
    func updatePassword(cellphone : String , msgCode : String, newPassword : String, finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/shiro/changepassword"
        
        // 2.获取请求的参数
        let parameters = ["cellphone" : cellphone , "msgCode" : msgCode , "newPassword" : newPassword]
        
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


