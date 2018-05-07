//
//  MyMeetingController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/16.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class MyMeetingController: BaseViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    
    
    @IBOutlet weak var tableview: UITableView!
    //MARK: -ui控件
    @IBOutlet var typeBtn: UIButton!
    @IBOutlet var stateBtn: UIButton!
    @IBOutlet var timeBtn: UIButton!
    @IBOutlet var hospitalBtn: UIButton!
    @IBOutlet var doctorSB: UISearchBar!
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    
    var typePickerView:UIPickerView!
    var statePickerView:UIPickerView!
    var timePickerView:UIPickerView!
    var hospitalPickerView:UIPickerView!
    var alert : UIAlertController!
    var flag = false
    var timeArray:Array<String>? = ["全部","一周内","一个月内","半年内"]
    var typeArray:Array<String>? = ["全部类型","视频会议","普通会议"]
    var stateArray:Array<String>? = ["全部状态","待确定","已确定","已拒绝","已完成"]
    lazy var hospitalArray:Array<String>? =  ["全部医院"]
    lazy var MeetingModels : Array<MeetingModel> = [MeetingModel]()
    
    var hospitalSelect : Int?
    var timeSelect : Int?
    var stateSelect : Int?
    var typeSelect : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHospital()
        loadMeeting()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    private func initUI(){
        
      
        typeBtn.addTarget(self, action: #selector(typeBtnClick), for: .touchUpInside)
        stateBtn.addTarget(self, action: #selector(stateBtnClick), for: .touchUpInside)
        timeBtn.addTarget(self, action: #selector(timeBtnClick), for: .touchUpInside)
        hospitalBtn.addTarget(self, action: #selector(hospitalBtnClick), for: .touchUpInside)
        
        self.doctorSB.delegate = self
        
    }
    
}

//MARK: -事件处理函数
extension MyMeetingController{

    
    @objc private func typeBtnClick(){
        loadMeeting()
        alert = UIAlertController(title: "选择会议类型", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            if self.typeSelect != nil {
                self.typeBtn.setTitle(self.typeArray?[self.typeSelect!], for: .normal)
                self.loadMeeting()
            }
        }
        
        typePickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        typePickerView.delegate = self;
        typePickerView.dataSource = self
        
        alert.view.addSubview(typePickerView)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func stateBtnClick(){
        loadMeeting()
        alert = UIAlertController(title: "选择会议状态", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            if self.stateSelect != nil {
                self.stateBtn.setTitle(self.stateArray?[self.stateSelect!], for: .normal)
                self.loadMeeting()
            }
        }
        
        statePickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        statePickerView.delegate = self;
        statePickerView.dataSource = self
        
        alert.view.addSubview(statePickerView)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func timeBtnClick(){
        loadMeeting()
        alert = UIAlertController(title: "选择时间", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            if self.timeSelect != nil {
                self.timeBtn.setTitle(self.timeArray?[self.timeSelect!], for: .normal)
                self.loadMeeting()
            }
        }
        
        timePickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        timePickerView.delegate = self;
        timePickerView.dataSource = self
        
        alert.view.addSubview(timePickerView)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func hospitalBtnClick(){
        
        alert = UIAlertController(title: "选择医院", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            if self.hospitalSelect != nil {
                if self.hospitalSelect == 0{
                    self.hospitalBtn.setTitle("全部医院", for: .normal)
                    self.loadMeeting()
                }else{
                    self.hospitalBtn.setTitle("已选择", for: .normal)
                    self.loadMeeting()
                }
            }
        }
        
        hospitalPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        hospitalPickerView.delegate = self;
        hospitalPickerView.dataSource = self
        
        alert.view.addSubview(hospitalPickerView)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadMeeting()
    }
}
//MARK: -pickView需要实现的函数
extension MyMeetingController{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init(frame: CGRect( x:0, y:0, width:CGFloat(self.view.frame.size.width) , height:30))
        if pickerView == typePickerView {
            label.text = typeArray![row]
        }else if pickerView == statePickerView {
            label.text = stateArray![row]
        }else if pickerView == hospitalPickerView {
            label.text = hospitalArray![row]
        }else if pickerView == timePickerView {
            label.text = timeArray![row]
        }
        label.textAlignment = NSTextAlignment.center
        return label
    }
    /**
     设置选择框的行数
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePickerView {
            return (typeArray?.count)!
        }else if pickerView == statePickerView {
            return (stateArray?.count)!
        }else if pickerView == hospitalPickerView {
            return (hospitalArray?.count)!
        }else if pickerView == timePickerView {
            return (timeArray?.count)!
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
        if pickerView == typePickerView {
            typeSelect = row
        }else if pickerView == statePickerView {
            stateSelect = row
        }else if pickerView == hospitalPickerView {
            hospitalSelect = row
        }else if pickerView == timePickerView {
            timeSelect = row
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeetingModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(130)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "meetingDetail", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "oneView") as! MeetingDetailController
        vc1.viewModel = MeetingModels[indexPath.row]
        self.present(vc1, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "meetingcell") as? MeetingViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = MeetingModels[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
}
//MARK: -网络请求函数

extension MyMeetingController{
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
    
    func loadMeeting() {
        self.MeetingModels.removeAll()
        var dayType : Int?
        var doctor_id : String?
        var hospitalName : String?
        var isApply : Int?
        var name : String?
        var state : Int?
        var type : String?
        
        if flag {
            isApply = 0
        }else{
            isApply = 1
        }
        dayType = timeSelect
        doctor_id = User.shareInstance.userid
        if hospitalSelect != 0 , hospitalSelect != nil{
            hospitalName = hospitalArray?[hospitalSelect!]
        }
        if let doctorname = doctorSB.text , !doctorname.isEmpty {
            name = doctorname
        }
        if stateSelect != 0 , stateSelect != nil{
            state = stateSelect!-1
        }
        if typeBtn.title(for: .normal) == "视频会议" {
            type = "视频"
        }else if typeBtn.title(for: .normal) == "普通会议" {
            type = "普通"
        }
        
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/getapply"
        //添加请求头
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        var parameter = ["doctor_id" : doctor_id!,"pageNum" : 1,"pageSize" : 50] as [String : Any]
        if dayType != nil {
            parameter["dayType"] = dayType
        }
        if hospitalName != nil {
            parameter["hospitalName"] = hospitalName
        }
        if name != nil {
            parameter["name"] = name
        }
        
        if state != nil {
            parameter["state"] = state
        }
        
        if type != nil {
            parameter["type"] = type
        }
        
        
        if isApply != nil {
            parameter["isApply"] = isApply
        }
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameter) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                self.alertView(title: "网络请求失败")
                return
            }
            
            guard let date = resultDic["data"] as? [String:Any] else {
                return
            }
            
            guard let sourceArray = date["source"] as? [[String:Any]] else {
                return
            }
            
            for source in sourceArray {
                let meetingModel = MeetingModel(dict: source)
                self.MeetingModels.append(meetingModel)
            }
            
            self.tableview.reloadData()
        }
        
    }
}

