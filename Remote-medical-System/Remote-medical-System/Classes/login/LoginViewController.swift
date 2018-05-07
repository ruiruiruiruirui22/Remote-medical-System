//
//  LoginViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/21.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    //MARK: -ui控件
    @IBOutlet var UsernameTF: UITextField!
    @IBOutlet weak var UsernameLable: UILabel!
    @IBOutlet var PasswordTF: UITextField!
    @IBOutlet weak var MessageTF: UITextField!
    @IBOutlet weak var MessageBtn: UIButton!
    @IBOutlet var LoginBtn: UIButton!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var pwdLable: UILabel!
    private var green : UIColor?
    @IBOutlet weak var Swift: UISwitch!

    @IBAction func LoginSwift(_ sender: UISwitch) {
   
        let state = sender.isOn
        if state {
            UsernameLable.text = "手机"
            UsernameTF.placeholder = "11位中国大陆号码"
            PasswordLabel.textColor = UIColor.darkGray
            MessageLabel.textColor = green
            MessageTF.isHidden=false
            MessageBtn.isHidden=false
            PasswordTF.isHidden=true
            pwdLable.isHidden=true
        }else{
            UsernameLable.text = "账号"
            UsernameTF.placeholder = "用户名/手机号码/邮箱"
            PasswordLabel.textColor = green
            MessageLabel.textColor = UIColor.darkGray
            MessageTF.isHidden=true
            MessageBtn.isHidden=true
            PasswordTF.isHidden=false
            pwdLable.isHidden=false
        }
    }
    //MARK: -系统回调方法
    override func viewDidLoad() {
     
        green = PasswordLabel.textColor
        super.viewDidLoad()
        LoginBtn.addTarget(self, action: #selector(ClickLoginBtn), for: .touchUpInside)
    }

}

//MARK: -事件处理函数
extension LoginViewController{
    @objc private func ClickLoginBtn(){
     
        guard let username = UsernameTF!.text, !username.isEmpty else {
           alertView(title: "请输入手机号！")
           return
        }
        
        guard ValidateTools.shareInstance.PhoneNumberIsValidated(vStr: username) else {
            alertView(title: "请输入正确的手机号！")
            return
        }
        
        if !Swift.isOn {
            guard let password = PasswordTF!.text , !password.isEmpty else {
                alertView(title: "请输入密码！")
                return
            }
            guard ValidateTools.shareInstance.PasswordIsValidated(vStr: password) else {
                alertView(title: "请输入6位以上的密码！")
                return
            }
            
        
            loginByPassword(username: username, password: password) { (result, error) -> () in
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
                        self.alertView(title: "验证失败！")
                        return
                    }
                }
                
                if let dateDic = result!["data"] {
                    User.shareInstance.accesstoken = dateDic!["accesstoken"] as? String
                    User.shareInstance.userid = dateDic!["userid"] as? String
                    User.shareInstance.userType = dateDic!["userType"] as? String
                    self.getDoctorDetail(doctorId: User.shareInstance.userid!) { (result, error) in
                        if error != nil {
                            self.alertView(title: "网络请求失败！")
                            return
                        }
                        
                        if let resultDic = result!["result"] {
                            let code = resultDic!["code"] as! String
                            if code == "500" {
                                self.alertView(title: "请求用户信息失败！")
                                return
                            }
                        }
                        
                        if let dataDic = result!["data"] {
                            guard let realName  = dataDic!["realName"] as? String, !realName.isEmpty else{
                                let toast = ToastView()
                                 User.shareInstance.cellphone = dataDic!["cellphone"] as? String
                                toast.showToast(text: "请先完善信息", pos: .Mid)
                                Thread.sleep(forTimeInterval: 0.5)
                                let sb = UIStoryboard(name: "login", bundle: nil)
                                let vc = sb.instantiateViewController(withIdentifier: "InformationVC") as! InformationViewController
                                self.present(vc, animated: true, completion: nil)
                                return
                            }
                            User.shareInstance.realName = realName
                            User.shareInstance.cellphone = dataDic!["cellphone"] as? String
                            User.shareInstance.department = dataDic!["department"] as? String
                            User.shareInstance.email = dataDic!["email"] as? String
                            User.shareInstance.hospital = dataDic!["hospital"] as? String
                            if let icon = dataDic!["icon"] as? String,!icon.isEmpty {
                                User.shareInstance.icon = icon
                            }
                            User.shareInstance.prositionalTitle = dataDic!["prositionalTitle"] as? String
                            User.shareInstance.username = dataDic!["userName"] as? String
                        }
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "MainView") as! MainViewController
                        self.present(vc, animated: true, completion: nil)
                        
                        
                        
                    }
                }
                
            }
        }else{
            guard let msgCode = MessageTF!.text, !msgCode.isEmpty else {
                alertView(title: "请输入验证码！")
                return
            }
            
            guard ValidateTools.shareInstance.MessageIsValidated(vStr: msgCode) else {
                alertView(title: "请输入6位数字验证码！")
                return
            }
            
            loginByMessage(cellphone: username, msgCode: msgCode) { (result, error) -> () in
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
                    self.getDoctorDetail(doctorId: User.shareInstance.userid!) { (result, error) in
                        if error != nil {
                            self.alertView(title: "网络请求失败！")
                            return
                        }
                        
                        if let resultDic = result!["result"] {
                            let code = resultDic!["code"] as! String
                            if code == "500" {
                                self.alertView(title: "请求用户信息失败！")
                                return
                            }
                        }
                        
                        if let dataDic = result!["data"] {
                            
                            //跳转到完善信息
                            guard let realName  = dataDic!["realName"] as? String, !realName.isEmpty else{
                               
                                let sb = UIStoryboard(name: "login", bundle: nil)
                                let vc = sb.instantiateViewController(withIdentifier: "InformationVC") as! InformationViewController
                                self.present(vc, animated: true, completion: nil)
                                return
                            }
                            User.shareInstance.cellphone = dataDic!["cellphone"] as? String
                            User.shareInstance.department = dataDic!["department"] as? String
                            User.shareInstance.email = dataDic!["email"] as? String
                            User.shareInstance.hospital = dataDic!["hospital"] as? String
                            if let icon = dataDic!["icon"] as? String,!icon.isEmpty {
                                User.shareInstance.icon = icon
                            }
                            User.shareInstance.prositionalTitle = dataDic!["prositionalTitle"] as? String
                            User.shareInstance.username = dataDic!["username"] as? String
                        }
                        //跳转到首页
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let vc = sb.instantiateViewController(withIdentifier: "MainView") as! MainViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
               
            }
            
        }
        
        
       
        
        
       
    }

    @objc public override func actionSendMessage(){
       
        guard let username = UsernameTF!.text, !username.isEmpty else {
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
extension LoginViewController{
    
    func loginByPassword(username : String , password : String, finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
    // 1.获取请求的URLString
    let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/shiro/loginbypassword"

    // 2.获取请求的参数
        let parameters = ["mailorcellphone" : username , "password" : password]
    
    // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.POST.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : [String : Any]?] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
    
    func loginByMessage(cellphone : String , msgCode : String, finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/shiro/loginbymsg"
        
        // 2.获取请求的参数
        let parameters = ["cellphone" : cellphone , "msgCode" : msgCode]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.POST.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : [String : Any]?] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
    
    func getDoctorDetail(doctorId : String , finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/doctor/getdoctorindetail"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        let parameters = ["doctorId" : doctorId]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : [String : Any]?] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
    
}
