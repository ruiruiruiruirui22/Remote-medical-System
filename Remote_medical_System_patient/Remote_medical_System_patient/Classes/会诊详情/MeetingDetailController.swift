//
//  MeetingDetailController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/11.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class MeetingDetailController: BaseViewController {
    
    //MARK: -ui控件
    //第一页
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var oneContain: UIView!
    @IBOutlet weak var twoContain: UIView!
    @IBOutlet weak var threeContain: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var applytimeLable: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var meetingtimeLabel: UILabel!
    @IBOutlet weak var nameTV: UITextView!
    @IBOutlet weak var phoneTV: UITextView!
    @IBOutlet weak var sexTV: UITextView!
    @IBOutlet weak var ismarryTV: UITextView!
    @IBOutlet weak var birthdayTV: UITextView!
    @IBOutlet weak var occupationTV: UITextView!
    @IBOutlet weak var medicalHistoryTF: UITextField!
    
    //第二页
    @IBOutlet weak var disasterDiscriptionTF: UITextField!
    @IBOutlet weak var ishospitalTF: UITextField!
    @IBOutlet weak var operationTF: UITextField!
    @IBOutlet weak var waishangTF: UITextField!
    @IBOutlet weak var manxingbingTF: UITextField!
    
    //第三页
    @IBOutlet weak var applydoctornameLabel: UILabel!
    @IBOutlet weak var applydoctorhospitalLabel: UILabel!
    @IBOutlet weak var applydoctordepartmentLabel: UILabel!
    @IBOutlet weak var applyeddoctornameLabel: UILabel!
    @IBOutlet weak var applyeddoctorhospitalLabel: UILabel!
    @IBOutlet weak var applyeddoctordepartmentLabel: UILabel!
    @IBOutlet weak var cancelMeetingBtn: UIButton!
    @IBOutlet weak var enterVideoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    var viewModel :MeetingModel?
    
}


//MARK: -控件处理
extension MeetingDetailController{
    private func initUI(){
        guard let viewModel = viewModel else {
            return
        }
        if segment != nil {
            segment.addTarget(self, action: #selector(segmentClick), for: .valueChanged)
        }
        
        if descriptionLabel != nil{
            descriptionLabel.text = viewModel.meeting.disasterDescription
        }
        
        if applytimeLable != nil{
            applytimeLable.text = "申请时间：" + viewModel.meeting.applyTime!
        }
        
        if doctorLabel != nil{
            doctorLabel.text = viewModel.applyDoctor.realName
        }
        
        if hospitalLabel != nil{
            hospitalLabel.text = viewModel.applyDoctor.hospital
        }
        
        if departmentLabel != nil{
            departmentLabel.text = viewModel.applyDoctor.department
        }
        
        
        
        var state = ""
        switch viewModel.meeting.state! {
        case 0:
            state = "当前状态：专家待确认"
            if viewModel.applyDoctor.id == User.shareInstance.userid {
                if cancelMeetingBtn != nil {
                    cancelMeetingBtn.backgroundColor = UIColor(displayP3Red: 255/255, green: 172/255, blue: 75/255, alpha: 1)
                    cancelMeetingBtn.setTitle("编辑内容", for:.normal)
                    cancelMeetingBtn.addTarget(self, action: #selector(editMeeting), for: .touchUpInside)
                }
                
                if enterVideoBtn != nil {
                    enterVideoBtn.setTitle("取消申请", for:.normal)
                    enterVideoBtn.addTarget(self, action: #selector(cancelMeeting),     for: .touchUpInside)
                }
            }else{
                
            }
        case 1:
            state = "当前状态：专家已确认"
            if cancelMeetingBtn != nil {
                cancelMeetingBtn.backgroundColor = UIColor(displayP3Red: 255/255, green: 172/255, blue: 75/255, alpha: 1)
                cancelMeetingBtn.setTitle("取消会议", for:.normal)
                cancelMeetingBtn.addTarget(self, action: #selector(cancelMeeting), for: .touchUpInside)
            }
            
           
        case 2:
            state = "当前状态：专家已拒绝"
            if cancelMeetingBtn != nil {
                cancelMeetingBtn.backgroundColor = UIColor(displayP3Red: 255/255, green: 172/255, blue: 75/255, alpha: 1)
                cancelMeetingBtn.setTitle("查看拒绝原因", for:.normal)
                cancelMeetingBtn.addTarget(self, action: #selector(lookforreject), for: .touchUpInside)
            }
            
            if enterVideoBtn != nil {
                enterVideoBtn.setTitle("重新申请", for:.normal)
                enterVideoBtn.addTarget(self, action: #selector(editMeeting), for: .touchUpInside)
            }
        case 3:
            state = "当前状态：会议已结束"
            if cancelMeetingBtn != nil {
                cancelMeetingBtn.backgroundColor = UIColor(displayP3Red: 255/255, green: 172/255, blue: 75/255, alpha: 1)
                cancelMeetingBtn.setTitle("查看报告", for:.normal)
                cancelMeetingBtn.addTarget(self, action: #selector(lookforreport), for: .touchUpInside)
            }
            
           
        default:
            state = "当前状态：会议已取消"
        }
        if  stateLabel != nil{
            stateLabel.text = state
        }
        
        if  meetingtimeLabel != nil{
            meetingtimeLabel.text = "会议时间：" + viewModel.meeting.meetingTime!
        }
        
        if  nameTV != nil{
            nameTV.text = viewModel.meeting.name
        }
        
        if  stateLabel != nil{
            stateLabel.text = state
        }
        
        if  stateLabel != nil{
            stateLabel.text = state
        }
        
        if  phoneTV != nil{
            phoneTV.text = viewModel.meeting.cellphone
        }
        
        if  sexTV != nil{
            sexTV.text = viewModel.meeting.sex
        }
        
        if  ismarryTV != nil{
            ismarryTV.text = viewModel.meeting.ismarry
        }
        
        if  birthdayTV != nil{
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if viewModel.meeting.birthday != nil {
                
                let date = dformatter.date(from:viewModel.meeting.birthday! )
                let dformatter2 = DateFormatter()
                dformatter2.dateFormat = "yyyy年MM月dd日"
                let datestr = dformatter2.string(from: date!)
                birthdayTV.text = datestr
            }
        }
        
        if  occupationTV != nil{
            occupationTV.text = viewModel.meeting.occupation
        }
        
        if  medicalHistoryTF != nil{
            medicalHistoryTF.text = viewModel.meeting.medicalHistory
        }
        
        if  disasterDiscriptionTF != nil{
            disasterDiscriptionTF.text = viewModel.meeting.disasterDescription
        }
        
        if  ishospitalTF != nil{
            ishospitalTF.text = viewModel.meeting.isHospital
        }
        
        if  operationTF != nil{
            operationTF.text = viewModel.meeting.operationDescription
        }
        if  waishangTF != nil{
            waishangTF.text = viewModel.meeting.traumaDescription
        }
        if  manxingbingTF != nil{
            manxingbingTF.text = viewModel.meeting.chronicDescription
        }
        
        if  applydoctornameLabel != nil{
            applydoctornameLabel.text = viewModel.applyDoctor.realName
        }
        if  ishospitalTF != nil{
            ishospitalTF.text = viewModel.meeting.isHospital
        }
        if  applydoctorhospitalLabel != nil{
            applydoctorhospitalLabel.text = viewModel.applyDoctor.hospital
        }
        
        if  applydoctordepartmentLabel != nil{
            applydoctordepartmentLabel.text = viewModel.applyDoctor.department
        }
        
        var doctorString = ""
        var hospitalString = ""
        var departmentString = ""
        for applyedDoctor in viewModel.applyedDoctors {
            doctorString.append(applyedDoctor.realName!+"\n")
            hospitalString.append(applyedDoctor.hospital!+"\n")
            departmentString.append(applyedDoctor.department!+"\n")
        }
        
        if applyeddoctornameLabel != nil {
            applyeddoctornameLabel.text = doctorString
        }
        if applyeddoctorhospitalLabel != nil {
            applyeddoctorhospitalLabel.text = hospitalString
        }
        if applyeddoctordepartmentLabel != nil {
            applyeddoctordepartmentLabel.text = departmentString
        }
        
        
    }
}

//MARK: -事件处理函数
extension MeetingDetailController{
    
    
    
    @objc private func lookforreport(){
        
        let sb = UIStoryboard(name: "meetingDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "report") as! MeetingResultController
        vc.result = viewModel?.result
        vc.chatRoomId = "\(viewModel?.meeting.id ?? 0)"
        vc.userName = User.shareInstance.username
        self.present(vc, animated: true, completion: nil)
    }
    
   
    
  
    @objc private func receiveApply(){
        receiveMeeting(meeting_id: (viewModel?.meeting.id)!, doctor_id: User.shareInstance.userid!)
    }
    @objc private func lookforreject(){
        self.alertView(title: (viewModel?.result?.reject)!)
    }
    @objc private func editMeeting(){
        Meeting.shareInstance.name = viewModel?.meeting.name
        Meeting.shareInstance.cellphone = viewModel?.meeting.cellphone
        Meeting.shareInstance.sex = viewModel?.meeting.sex
        Meeting.shareInstance.ismarry = viewModel?.meeting.ismarry
        Meeting.shareInstance.birthday = viewModel?.meeting.birthday
        Meeting.shareInstance.occupation = viewModel?.meeting.occupation
        Meeting.shareInstance.medicalHistory = viewModel?.meeting.medicalHistory
        Meeting.shareInstance.disasterDescription = viewModel?.meeting.disasterDescription
        Meeting.shareInstance.isHospital = viewModel?.meeting.isHospital
        Meeting.shareInstance.operationDescription = viewModel?.meeting.operationDescription
        Meeting.shareInstance.traumaDescription = viewModel?.meeting.traumaDescription
        Meeting.shareInstance.chronicDescription = viewModel?.meeting.chronicDescription
        Meeting.shareInstance.meetingTime = viewModel?.meeting.meetingTime
        
   

        
    }
    
    @objc private func cancelMeeting(){
        deleteMeeting(meeting_id: (viewModel?.meeting.id)!) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            guard let date = result!["result"] as? [String:Any] else{
                return
            }
            
            guard let code = date["code"] as? String else{
                return
            }
            if code == "200" {
                let view = ToastView()
                view.showToast(text: "取消会议成功", pos: .Mid)
            }else if code == "509" {
                let view = ToastView()
                view.showToast(text: "取消会议成功", pos: .Mid)
                Thread.sleep(forTimeInterval: 0.5)
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainView") as! MainViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "one"
        {
            let detailVc = segue.destination as! MeetingDetailController
            detailVc.viewModel = self.viewModel
        }
        if segue.identifier == "two"
        {
            let detailVc = segue.destination as! MeetingDetailController
            detailVc.viewModel = self.viewModel
        }
        if segue.identifier == "three"
        {
            let detailVc = segue.destination as! MeetingDetailController
            detailVc.viewModel = self.viewModel
        }
        
    }
    
    
    
    @objc private func segmentClick(){
        switch segment.selectedSegmentIndex
        {
        case 0:
            oneContain.isHidden = false
            twoContain.isHidden = true
            threeContain.isHidden = true
        case 1:
            oneContain.isHidden = true
            twoContain.isHidden = false
            threeContain.isHidden = true
        case 2:
            oneContain.isHidden = true
            twoContain.isHidden = true
            threeContain.isHidden = false
        default:
            break;
        }
    }
}


extension MeetingDetailController{
    private func deleteMeeting(meeting_id : Int, finished : @escaping (_ result : [String : Any]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/deletemeeting"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["meeting_id" : meeting_id]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
                guard let resultDic = result as? [String : Any] else{
                    finished(nil,error)
                    return
                }
                finished(resultDic,error)
            }
        }
    }
    private func receiveMeeting(meeting_id : Int, doctor_id : String) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/handlemeeting"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["meeting_id" : meeting_id , "doctor_id" : doctor_id , "operation" : 1] as [String : Any]
        
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

