//
//  InformationViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/24.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class InformationViewController: BaseViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var hospitalTF: UITextField!
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var realnameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    var hospitalPickerView:UIPickerView!
    var departmentPickerView:UIPickerView!
    var alert : UIAlertController!
    
    var flag = true
    var hospitalSelect : Int?
    var departmentSelect : Int?
    var ismarrySelect : Int?
    lazy var hospitalArray:Array<String>? = [String]()
    lazy var departmentArray:Array<String>? = [String]()
    
    @IBOutlet weak var finishBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHospital()
        finishBtn.addTarget(self, action: #selector(informationClick), for: .touchUpInside)
        hospitalTF.addTarget(self, action: #selector(hospitalTFClick), for: .touchDown)
        departmentTF.addTarget(self, action: #selector(departmentTFClick), for: .touchDown)
    }
    
}




//MARK: -事件处理函数
extension InformationViewController {
    @objc  private func informationClick(){
        guard let hospital = hospitalTF!.text , !hospital.isEmpty else {
            alertView(title: "请选择医院！")
            return
        }
        User.shareInstance.hospital = hospital
        guard let department = departmentTF.text,!department.isEmpty else{
            alertView(title: "请选择科室！")
            return
        }
        User.shareInstance.department = department
        guard let position = positionTF.text ,!position.isEmpty else{
            alertView(title: "请选择职称！")
            return
        }
        User.shareInstance.prositionalTitle = position
        guard let realname = realnameTF.text ,!realname.isEmpty else{
            alertView(title: "请输入您的真实姓名！")
            return
        }
        User.shareInstance.realName = realname
        guard let username = usernameTF.text,!username.isEmpty else{
            alertView(title: "请输入用户名！")
            return
        }
        User.shareInstance.username = username
        guard let email = emailTF.text ,!email.isEmpty else{
            alertView(title: "请输入邮箱！")
            return
        }
        
        guard ValidateTools.shareInstance.EmailIsValidated(vStr: email) else{
            alertView(title: "请输入正确的邮箱格式！")
            return
        }
        User.shareInstance.email = email
        information(hospital: hospital, department: department, prositionalTitle: position, realName: realname, userName: username, mail: email) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code == "511" {
                    self.alertView(title: resultDic!["msg"] as! String)
                    return
                }else if code == "500"{
                    self.alertView(title:"更新用户信息失败！")
                    return
                }
            }
            let toast = ToastView()
            toast.showToast(text: "完善信息成功", pos: .Mid)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainView") as! MainViewController
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    @objc  private func hospitalTFClick(){
        alert = UIAlertController(title: "选择医院", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.hospitalTF.isEnabled = true
            self.hospitalTF.text = self.hospitalArray?[self.hospitalSelect ?? 0]
            self.loadDepartment(hospitalName: (self.hospitalArray?[self.hospitalSelect ?? 0])!)
        }
        
        hospitalPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        hospitalPickerView.delegate = self;
        hospitalPickerView.dataSource = self
        
        alert.view.addSubview(hospitalPickerView)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc  private func departmentTFClick(){
        guard let hospital = self.hospitalTF.text,!hospital.isEmpty else{
            self.alertView(title: "请先选择医院")
            return
        }
        
        alert = UIAlertController(title: "选择科室", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.departmentTF.isEnabled = true
            self.departmentTF.text = self.departmentArray?[self.departmentSelect ?? 0]
        }
        
        departmentPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        departmentPickerView.delegate = self;
        departmentPickerView.dataSource = self
        
        alert.view.addSubview(departmentPickerView)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init(frame: CGRect( x:0, y:0, width:CGFloat(self.view.frame.size.width) , height:30))
        if pickerView == hospitalPickerView {
            label.text = hospitalArray![row]
        }else if pickerView == departmentPickerView {
            label.text = departmentArray![row]
        }
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    /**
     设置选择框的行数
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hospitalPickerView {
            return (hospitalArray?.count)!
        }else if pickerView == departmentPickerView{
            return (departmentArray?.count)!
        }
        return 0
    }
    
    // MARK: UIPickerViewDataSource
    /**
     设置选择框的列数
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == hospitalPickerView {
            self.hospitalTF.text = hospitalArray?[row]
            hospitalSelect = row
        }else{
            self.departmentTF.text = departmentArray?[row]
            departmentSelect = row
        }
    }
    
}

//MARK: -网络请求函数
extension InformationViewController{
    func information(hospital : String , department : String, prositionalTitle : String,realName : String, userName : String , mail : String , finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/doctor/doctorregister"
        //添加请求头
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        
        // 2.获取请求的参数
        let parameters = ["department" : department, "hospital" :  hospital , "mail" : mail , "prositionalTitle" : prositionalTitle , "realName" : realName , "userName" : userName , "userid" : User.shareInstance.userid! ]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.POST.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : [String : Any]?] else{
                finished(nil,error)
                return
            }
            
            finished(resultDic,error)
        }
    }
    
    func loadHospital() {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/hospital/gethospital"
        //添加请求头
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        
        let parameter = ["" : ""]
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameter) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                self.alertView(title: "网络请求失败")
                return
            }
            
            guard let dateArray = resultDic["data"] as? [[String:Any]] else {
                return
            }
            
            for date in dateArray {
                let hospital = date["hospitalName"] as! String
                self.hospitalArray?.append(hospital)
            }
        }
    }
    
    func loadDepartment(hospitalName : String) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/hospitaldepartment/getdepartmentlist"
        //添加请求头
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        
        let parameter = ["hospitalId" : 1]
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameter) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                self.alertView(title: "网络请求失败")
                return
            }
            
            guard let dateArray = resultDic["data"] as? [[String:Any]] else {
                return
            }
            
            for date in dateArray {
                let department = date["departmentName"] as! String
                self.departmentArray?.append(department)
            }
        }
    }
    
}



