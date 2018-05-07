//
//  BaseViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    public var user : User?
    public var backColor:UIColor?
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0{
        willSet {
            sendMessageBtn.setTitle("重新获取(\(newValue))", for: .normal)
            if newValue <= 0 {
                sendMessageBtn.setTitle("发送验证码", for: .normal)
                isCounting = false
            }
        }
        
    }
    
    @objc func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                sendMessageBtn.backgroundColor = UIColor.gray
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                sendMessageBtn.backgroundColor = backColor
            }
            sendMessageBtn.isEnabled = !newValue
        }
    }

    

    @IBOutlet weak var backBtn: UIButton!
 
    @IBOutlet weak var sendMessageBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackBtn()
        addSendMessageBtn()
        // Do any additional setup after loading the view.
    }

}
//MARk: -添加控件
extension BaseViewController{
    

    public func addBackBtn(){
        if backBtn != nil {
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        }
        
    }
    public func addSendMessageBtn(){
         if sendMessageBtn != nil {
                sendMessageBtn.addTarget(self, action: #selector(actionSendMessage), for: .touchUpInside)
        }
        
    }
    
    public func alertView(title : String){
    let alertController = UIAlertController(title: nil,
                                            message: title, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "我知道了", style: .default, handler:nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
    }
}


//MARk: -添加事件
extension BaseViewController{
    @objc private func actionBack(){
        self.dismiss(animated: true, completion: nil)
    }
  
    @objc public func actionSendMessage(){}
  
}


//MARK: -网络请求函数
extension BaseViewController{
    
    
    func sendMeesage(cellphone : String , finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let toast = ToastView()
        toast.showToast(text: "发送成功，请耐心等待", pos: .Mid)
        backColor = sendMessageBtn.backgroundColor
        isCounting = true
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/shiro/sendmsgcode"
        
        // 2.获取请求的参数
        let parameters = ["cellphone" : cellphone]
        
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
