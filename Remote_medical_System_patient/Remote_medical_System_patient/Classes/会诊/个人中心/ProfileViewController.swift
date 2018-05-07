//
//  ProfileViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/11.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    //MARK: -ui控件
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var realnameLable: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var ExitBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var guanyuTextField: UITextField!
    
    
    //MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initUI()
    }
    
}

extension ProfileViewController{
    private func  initUI(){
        if let icon = User.shareInstance.icon, !icon.isEmpty {
            if let iconURL = URL(string : icon)  {
                iconImage.sd_setImage(with: iconURL, completed: nil)
            }
        }
        if let realname = User.shareInstance.realName, !realname.isEmpty {
            realnameLable.text = realname
        }
       
        
        if let username = User.shareInstance.username, !username.isEmpty {
            usernameTF.text = username
        }
        
        if let email = User.shareInstance.email, !email.isEmpty {
            emailTF.text = email
        }
        
        if let cellphone = User.shareInstance.cellphone, !cellphone.isEmpty {
            phoneTF.text = cellphone
        }
        ExitBtn.addTarget(self, action: #selector(exitBtnClick),for: .touchUpInside)
        usernameTF.addTarget(self, action: #selector(modifierUsername), for: .touchDown)
        emailTF.addTarget(self, action: #selector(modifierEmail), for: .touchDown)
        phoneTF.addTarget(self, action: #selector(modifierPhone), for: .touchDown)
        passwordTF.addTarget(self, action: #selector(modifierPassword), for: .touchDown)
        guanyuTextField.addTarget(self, action: #selector(showGuanyu), for: .touchDown)
    }
}

//MARK: -事件处理函数
extension ProfileViewController{
    @objc private func modifierUsername(){
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "modifierView") as! ModifierViewController
        vc.username = usernameTF.text
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func modifierEmail(){
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "modifierView") as! ModifierViewController
        vc.email = emailTF.text
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func modifierPhone(){
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "modifierView") as! ModifierViewController
        vc.phone = phoneTF.text
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func modifierPassword(){
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ModifierPassword") as! ModifierPasswordViewController
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func showGuanyu(){
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "guanyuView") as! ModifierViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func exitBtnClick(){
        User.reset()
        let sb = UIStoryboard(name: "login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
}

