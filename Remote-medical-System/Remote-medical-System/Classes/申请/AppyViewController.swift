//
//  AppyViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/29.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class AppyViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
 
    


    //MARK: -ui控件
    //1
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cellphoneTF: UITextField!
    @IBOutlet weak var sexTF: UITextField!
    @IBOutlet weak var ismarryTF: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var occupationTF: UITextField!
    @IBOutlet weak var medicalHistoryTF: UITextField!
    @IBOutlet weak var sexSelected: UIButton!
    @IBOutlet weak var ismarrySelected: UIButton!
    @IBOutlet weak var birthdaySelected: UIDatePicker!
    @IBOutlet weak var birthdaySelectedSure: UIButton!
    @IBOutlet weak var birthdayView: UIView!
    //2
    @IBOutlet weak var disasterDescriptionTF: UITextField!
    @IBOutlet weak var isHospitalTF: UITextField!
    @IBOutlet weak var operationDescriptionTF: UITextField!
    @IBOutlet weak var traumaDescriptionTF: UITextField!
    @IBOutlet weak var chronicDescriptionTF: UITextField!
    @IBOutlet weak var uploadFileBtn: UIButton!
    @IBOutlet weak var lastBtn: UIButton!
    @IBOutlet weak var nextBtn2: UIButton!
     //3
    @IBOutlet weak var selectDoctorSB: UISearchBar!
    @IBOutlet weak var howmanyDoctorBtn: UIButton!
    @IBOutlet weak var nextBtn3: UIButton!
    @IBOutlet weak var hospitalTF: UITextField!
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var oneMore: UIImageView!
    @IBOutlet weak var twomore: UIImageView!
    
    @IBOutlet weak var doctorTV: UITableView!
    //4
    @IBOutlet weak var MeetingDateTF: UITextField!
    @IBOutlet weak var MeetingTimeTF: UITextField!
    @IBOutlet weak var meetingDateSelected: UIButton!
    @IBOutlet weak var meetingTimeSelected: UIButton!
    
    @IBOutlet weak var finshCreateBtn: UIButton!
    @IBOutlet weak var dataSelectView: UIView!
    @IBOutlet weak var dataSelectSure: UIButton!
    @IBOutlet weak var dataSelect: UIDatePicker!
    @IBOutlet weak var timeSelectView: UIView!
    @IBOutlet weak var timeSelect: UIDatePicker!
    @IBOutlet weak var timeSelectSure: UIButton!
    
    
    var sexPickerView:UIPickerView!
    var ismarryPickerView:UIPickerView!
    var hospitalPickerView:UIPickerView!
    var departmentPickerView:UIPickerView!
    var alert : UIAlertController!
    
    var hospitalSelect : Int?
    var departmentSelect : Int?
    var sexSelect : Int?
    var flag = true
    var ismarrySelect : Int?
    var sexArray:Array<String>? = ["男","女"]
    var ismarryArray:Array<String>? = ["未婚","已婚"]
    lazy var hospitalArray:Array<String>? = [String]()
    lazy var departmentArray:Array<String>? = [String]()
    lazy var doctors : Array<Doctor> = [Doctor]()
    lazy var doctroidArray:Array<String>? = [String]()
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        loadDate()
    }
}

//
extension AppyViewController{
    private func loadDate(){
       loadHospital()
    }
    
    private func initUI(){
      
        if nameTF != nil {
            if let name = Meeting.shareInstance.name , !name.isEmpty {
                nameTF.text = name
            }
        }
        if cellphoneTF != nil{
            if let cellphone = Meeting.shareInstance.cellphone , !cellphone.isEmpty {
                cellphoneTF.text = cellphone
            }
        }
        
        if sexTF != nil{
            if let sex = Meeting.shareInstance.sex , !sex.isEmpty {
                sexTF.text = sex
            }
        }
        if ismarryTF != nil{
            if let ismarry = Meeting.shareInstance.ismarry , !ismarry.isEmpty {
                ismarryTF.text = ismarry
            }
        }
       
        if birthdayTF != nil{
            if let birthday = Meeting.shareInstance.birthday , !birthday.isEmpty {
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dformatter.date(from: birthday)
                
                let dformatter2 = DateFormatter()
                dformatter2.dateFormat = "yyyy-MM-dd"
                let dateStr = dformatter2.string(from: date!)
                
                birthdayTF.text = dateStr
            }
        }
        if occupationTF != nil{
            if let occupation = Meeting.shareInstance.occupation , !occupation.isEmpty {
                occupationTF.text = occupation
            }
        }
        if medicalHistoryTF != nil{
            if let medicalHistory = Meeting.shareInstance.medicalHistory , !medicalHistory.isEmpty {
                medicalHistoryTF.text = medicalHistory
            }
        }
        
        
        if disasterDescriptionTF != nil{
            if let disasterDescription = Meeting.shareInstance.disasterDescription , !disasterDescription.isEmpty {
                disasterDescriptionTF.text = disasterDescription
            }
        }
        if hospitalTF != nil {
            hospitalTF.addTarget(self, action: #selector(selectHospital), for: .touchDown)
        }
        
        if departmentTF != nil {
             departmentTF.addTarget(self, action: #selector(selectDepartment), for: .touchDown)
        }
        
        if isHospitalTF != nil{
            if let isHospital = Meeting.shareInstance.isHospital , !isHospital.isEmpty {
                isHospitalTF.text = isHospital
            }
        }
        
        if operationDescriptionTF != nil{
            if let operationDescription = Meeting.shareInstance.operationDescription , !operationDescription.isEmpty {
                operationDescriptionTF.text = operationDescription
            }
        }
        
        if selectDoctorSB != nil {
            self.selectDoctorSB.delegate = self
        }
        
        if traumaDescriptionTF != nil{
            if let traumaDescription = Meeting.shareInstance.traumaDescription , !traumaDescription.isEmpty {
                traumaDescriptionTF.text = traumaDescription
            }
        }
        
        if chronicDescriptionTF != nil{
            if let chronicDescription = Meeting.shareInstance.chronicDescription , !chronicDescription.isEmpty {
                chronicDescriptionTF.text = chronicDescription
            }
        }

        
        if let time = Meeting.shareInstance.meetingTime , !time.isEmpty{
            
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dformatter.date(from: time)
            
            let dformatter2 = DateFormatter()
            dformatter2.dateFormat = "yyyy-MM-dd"
            let dateStr = dformatter2.string(from: date!)
           
            let dformatter3 = DateFormatter()
            dformatter3.dateFormat = "HH:mm"
            let timeStr = dformatter3.string(from: date!)
            
            if MeetingDateTF != nil{
               MeetingDateTF.text = dateStr
            }
        
            if MeetingTimeTF != nil{
              MeetingTimeTF.text = timeStr
            }
        }
        
       
        
        if nextBtn != nil {
            self.nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        }
        if lastBtn != nil {
            self.lastBtn.addTarget(self, action: #selector(lastBtnClick), for: .touchUpInside)
        }
        if nextBtn2 != nil {
            self.nextBtn2.addTarget(self, action: #selector(nextBtn2Click), for: .touchUpInside)
        }

        if sexSelected != nil {
            sexSelected.addTarget(self, action: #selector(sexSelectedClick), for: .touchUpInside)
        }
        
        if sexTF != nil {
           
            sexTF.addTarget(self, action: #selector(sexSelectedClick), for: .touchDown)

        }
        
        if ismarrySelected != nil {
            ismarrySelected.addTarget(self, action: #selector(ismarrySelectedClick), for: .touchUpInside)
        }

        if ismarryTF != nil {
            ismarryTF.addTarget(self, action: #selector(ismarrySelectedClick), for: .touchDown)
        }
        
        if nextBtn3 != nil {
            self.nextBtn3.addTarget(self, action: #selector(nextBtn3Click), for: .touchUpInside)
        }
        if finshCreateBtn != nil {
            self.finshCreateBtn.addTarget(self, action: #selector(finshCreateBtnClick), for: .touchUpInside)
        }
        
        if birthdayTF != nil {
            self.birthdayTF.addTarget(self, action: #selector(birthdayTFClick), for: .touchDown)
        }
        
        if MeetingDateTF != nil {
             self.MeetingDateTF.addTarget(self, action: #selector(MeetingDateTFClick), for: .touchDown)
        }
        
        if MeetingTimeTF != nil {
            self.MeetingTimeTF.addTarget(self, action: #selector(MeetingTimeTFClick), for: .touchDown)
        }
        
        if dataSelect != nil {
            self.dataSelect.addTarget(self, action: #selector(MeetingDateTFClick), for: .touchUpInside)
        }
        
        if meetingDateSelected != nil {
            self.meetingDateSelected.addTarget(self, action: #selector(MeetingDateTFClick), for: .touchUpInside)
        }
        
        if meetingTimeSelected != nil {
            self.meetingTimeSelected.addTarget(self, action: #selector(MeetingTimeTFClick), for: .touchUpInside)
        }
        
        if timeSelect != nil {
            self.timeSelect.addTarget(self, action: #selector(MeetingTimeTFClick), for: .touchUpInside)
        }
        
        
        if birthdaySelectedSure != nil {
            self.birthdaySelectedSure.addTarget(self, action: #selector(birthdaySelectedSureClick), for: .touchUpInside)
        }
        
        if dataSelectSure != nil {
            self.dataSelectSure.addTarget(self, action: #selector(dateSelectSureClick), for: .touchUpInside)
        }
        
        if timeSelectSure != nil {
            self.timeSelectSure.addTarget(self, action: #selector(timeSelectSureClick), for: .touchUpInside)
        }
        
        if doctorTV != nil {
            self.doctorTV.dataSource = self
            self.doctorTV.delegate = self
            doctorTV.rowHeight = UITableViewAutomaticDimension
            // 设置预估行高 --> 先让 tableView 能滚动，在滚动的时候再去计算显示的 cell 的真正的行高，并且调整 tabelView 的滚动范围
            doctorTV.estimatedRowHeight = 99
        }
    }
}

//MARK: -事件处理函数
extension AppyViewController{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchDoctor()
    }
    
    @objc private func  searchDoctor(){
        let doctor = selectDoctorSB.text!
        var hospital = hospitalTF.text!
        if hospital == "全部医院" {
            hospital = ""
        }
        
        var department = departmentTF.text!
        if department == "全部科室" {
            department = ""
        }
        self.doctors.removeAll()
        loadDoctors(realName: doctor, hospital: hospital, department: department)
    }
    
    @objc private func ismarrySelectedClick(){
        flag = false
        ismarrySelected.isEnabled = false
        sexSelected.isEnabled = false
        birthdayTF.isEnabled = false
        ismarryTF.isEnabled = false
        
        alert = UIAlertController(title: "选择婚姻状况", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.ismarryTF.isEnabled = true
            self.ismarryTF.text = self.ismarryArray?[self.ismarrySelect ?? 0]
        }
        
        ismarryPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        ismarryPickerView.delegate = self;
        ismarryPickerView.dataSource = self
        
        alert.view.addSubview(ismarryPickerView)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc private func selectDepartment(){
        twomore.isHighlighted = true
        guard let hospital = self.hospitalTF.text , !hospital.isEmpty else{
            self.alertView(title: "请先选择医院")
            return
        }
        
        alert = UIAlertController(title: "选择科室", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.departmentTF.isEnabled = true
            self.twomore.isHighlighted = false
            self.departmentTF.text = self.departmentArray?[self.departmentSelect ?? 0]
            self.searchDoctor()
        }
        
        departmentPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        departmentPickerView.delegate = self;
        departmentPickerView.dataSource = self
        
        alert.view.addSubview(departmentPickerView)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func selectHospital(){
        oneMore.isHighlighted = true
        alert = UIAlertController(title: "选择医院", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.hospitalTF.isEnabled = true
            self.oneMore.isHighlighted = false
            self.hospitalTF.text = self.hospitalArray?[self.hospitalSelect ?? 0]
            self.loadDepartment(hospitalName: (self.hospitalArray?[self.hospitalSelect ?? 0])!)
            self.searchDoctor()
        }
        
        hospitalPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        hospitalPickerView.delegate = self;
        hospitalPickerView.dataSource = self
        
        alert.view.addSubview(hospitalPickerView)
        alert.addAction(cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func sexSelectedClick(){
        flag = true
        ismarrySelected.isEnabled = false
        sexSelected.isEnabled = false
         birthdayTF.isEnabled = false
        sexTF.isEnabled = false
      
        
        alert = UIAlertController(title: "选择性别", message: "\n\n\n", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            self.sexTF.isEnabled = true
            self.sexTF.text = self.sexArray?[self.sexSelect ?? 0]
        }
        
        sexPickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        sexPickerView.delegate = self;
        sexPickerView.dataSource = self
       
        alert.view.addSubview(sexPickerView)
        alert.addAction(cancel)
        
       
        self.present(alert, animated: true, completion: nil)
    }

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init(frame: CGRect( x:0, y:0, width:CGFloat(self.view.frame.size.width) , height:30))
        if pickerView == sexPickerView {
            label.text = sexArray![row]
        }else if pickerView == ismarryPickerView {
            label.text = ismarryArray![row]
        }else if pickerView == hospitalPickerView {
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
        if pickerView == sexPickerView {
            return (sexArray?.count)!
        }else if pickerView == ismarryPickerView {
            return (self.ismarryArray?.count)!
        }else if pickerView == hospitalPickerView {
            return (self.hospitalArray?.count)!
        }else if pickerView == departmentPickerView {
            return (self.departmentArray?.count)!
        }
        return 0
    }

    // MARK: UIPickerViewDataSource
    /**
     设置选择框的列数
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == sexPickerView {
            return 1
        }  else if pickerView == ismarryPickerView {
            return 1
        }  else if pickerView == hospitalPickerView {
            return 1
        }   else if pickerView == departmentPickerView {
            return 1
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sexPickerView {
           sexSelect = row
           ismarrySelected.isEnabled = true
           sexSelected.isEnabled = true
           birthdayTF.isEnabled = true
        }else if  pickerView == ismarryPickerView {
           ismarrySelect = row
           sexSelected.isEnabled = true
           ismarrySelected.isEnabled = true
           birthdayTF.isEnabled = true
        }else if  pickerView == hospitalPickerView {
            hospitalSelect = row
        }else if  pickerView == departmentPickerView {
            departmentSelect = row
           
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(98.5)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DoctorViewCell
        
        if (doctroidArray?.contains(doctors[indexPath.row].id!))! {
            cell?.checkBox.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
            let index = doctroidArray?.index(of: doctors[indexPath.row].id!)
            doctroidArray?.remove(at: index!)
        }else {
            cell?.checkBox.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
            doctroidArray?.append(doctors[indexPath.row].id!)
        }
        
        let num = (doctroidArray?.count)!
        self.howmanyDoctorBtn.setTitle("已选择\(num)名医生", for: .normal)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell") as? DoctorViewCell else {
            return UITableViewCell()
        }
        if (doctroidArray?.contains(doctors[indexPath.row].id!))! {
            cell.checkBox.setBackgroundImage(UIImage(named : "check_box_on"), for: .normal)
           
        }else {
            cell.checkBox.setBackgroundImage(UIImage(named : "check_box"), for: .normal)
        }
        
        cell.doctor = doctors[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    @objc private func nextBtnClick(){
        if let name = self.nameTF.text , !name.isEmpty{
           Meeting.shareInstance.name = name
        }
        
        
        if  let cellphone =  self.cellphoneTF.text,!cellphone.isEmpty{
            Meeting.shareInstance.cellphone = cellphone
        }
       
        if let sex = self.sexTF.text , !sex.isEmpty{
           Meeting.shareInstance.sex = sex
        }
        if let ismarry = self.ismarryTF.text , !ismarry.isEmpty{
            Meeting.shareInstance.ismarry = ismarry
        }
        if let birthday =  self.birthdayTF.text , !birthday.isEmpty{
            Meeting.shareInstance.birthday = birthday + " 00:00:00"
        }
        if let occupation = self.occupationTF.text , !occupation.isEmpty{
            Meeting.shareInstance.occupation = occupation
        }
        if let medicalHistory = self.medicalHistoryTF.text , !medicalHistory.isEmpty{
            Meeting.shareInstance.medicalHistory = medicalHistory
        }
       
        let sb = UIStoryboard(name: "apply", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "applyView2") as! AppyViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func lastBtnClick(){
        let sb = UIStoryboard(name: "apply", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "applyView1") as! AppyViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func birthdayTFClick(){
        //ui设置
        birthdaySelected.isHidden = false
        birthdaySelectedSure.isHidden = false
        birthdayView.isHidden = false
    }
    
    @objc private func MeetingDateTFClick(){
        //ui设置
        dataSelect.isHidden = false
        dataSelectSure.isHidden = false
        dataSelectView.isHidden = false
    }
    
    @objc private func MeetingTimeTFClick(){
        //ui设置
        timeSelect.isHidden = false
        timeSelectSure.isHidden = false
        timeSelectView.isHidden = false
    }
    
    @objc private func birthdaySelectedSureClick(){
        //ui设置
        birthdaySelected.isHidden = true
        birthdaySelectedSure.isHidden = true
        birthdayView.isHidden = true
        
        //设置时间
        let date = birthdaySelected.date
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        birthdayTF.text = datestr
    }
    
    @objc private func timeSelectSureClick(){
        //ui设置
        timeSelect.isHidden = true
        timeSelectSure.isHidden = true
        timeSelectView.isHidden = true
        
        //设置时间
        let date = timeSelect.date
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "HH:mm"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        MeetingTimeTF.text = datestr
    }
    
    @objc private func dateSelectSureClick(){
        //ui设置
        dataSelect.isHidden = true
        dataSelectSure.isHidden = true
        dataSelectView.isHidden = true
        
        //设置时间
        let date = dataSelect.date
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        MeetingDateTF.text = datestr
    }
    
   
    @objc private func nextBtn2Click(){
        if let disasterDescription = self.disasterDescriptionTF.text, !disasterDescription.isEmpty{
            Meeting.shareInstance.disasterDescription = disasterDescription
        }
        if let isHospital = self.isHospitalTF.text , !isHospital.isEmpty{
            Meeting.shareInstance.isHospital = isHospital
        }
        if let operationDescription = self.operationDescriptionTF.text , !operationDescription.isEmpty{
            Meeting.shareInstance.operationDescription = operationDescription
        }
        if let traumaDescription =  self.traumaDescriptionTF.text  , !traumaDescription.isEmpty{
            Meeting.shareInstance.traumaDescription  = traumaDescription
        }
        if let chronicDescription = self.chronicDescriptionTF.text, !chronicDescription.isEmpty{
            Meeting.shareInstance.chronicDescription = chronicDescription
        }
        let sb = UIStoryboard(name: "apply", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "applyView3") as! AppyViewController
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func nextBtn3Click(){
        var participateid = ""
        for s in doctroidArray! {
            participateid.append(s)
            if s != doctroidArray?.last {
                participateid.append(",")
            }
        }
        Meeting.shareInstance.participateId = participateid
        let sb = UIStoryboard(name: "apply", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "applyView4") as! AppyViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func finshCreateBtnClick(){
        var date = ""
        if let meetingDate =  self.MeetingDateTF.text  , !meetingDate.isEmpty{
           date += meetingDate+" "
        }
        if let MeetingTime =  self.MeetingTimeTF.text  , !MeetingTime.isEmpty{
            date += MeetingTime + ":00"
        }
        Meeting.shareInstance.decomPicture = "www.hao123.com"
        Meeting.shareInstance.meetingTime = date
        guard let manageid  = User.shareInstance.userid , !manageid.isEmpty else{
            self.alertView(title: "无法获取用户信息，请重新登录！")
           
            let sb = UIStoryboard(name: "login", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "loginview") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        Meeting.shareInstance.manageId = manageid
        insertMeeting(meeting: Meeting.shareInstance) { (result, error) in
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            if let resultDic = result!["result"] {
                let code = resultDic!["code"] as! String
                if code == "509" {
                    self.alertView(title: "用户不存在！")
                    return
                }else if code == "500" {
                    self.alertView(title: "操作失败！")
                    return
                }
            }
            
            let toast = ToastView()
            toast.showToast(text: "申请会议成功！", pos: .Mid)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainView") as! MainViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
   
}

//MARK: -网络请求函数
extension AppyViewController{
    func insertMeeting(meeting : Meeting , finished : @escaping (_ result : [String : [String : Any]?]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/insertmeeting"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        let parameters = ["birthday" : meeting.birthday,"cellphone": meeting.cellphone,"chronicDescription": meeting.chronicDescription,"decomPicture": meeting.decomPicture,
                          "disasterDescription": meeting.disasterDescription,"isHospital": meeting.isHospital,"ismarry": meeting.ismarry,
                          "manageId": meeting.manageId,"medicalHistory": meeting.medicalHistory,"meetingTime": meeting.meetingTime,"meetingType": meeting.meetingType,
                          "name": meeting.name ,"occupation": meeting.occupation,"operationDescription": meeting.operationDescription,"participateId": meeting.participateId,"sex": meeting.sex,"traumaDescription": meeting.traumaDescription]
        
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
             self.hospitalArray?.append("全部医院")
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
            self.departmentArray?.append("全部科室")
            for date in dateArray {
                let department = date["departmentName"] as! String
                self.departmentArray?.append(department)
            }
        }
    }
    
    func loadDoctors(realName : String , hospital : String , department : String) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/doctor/getdoctorlistByCondition"
        //添加请求头
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        
        let parameters = ["realName" : realName , "hospital" : hospital , "department" : department , "pageSize" : 50 , "pageNum" : 1] as [String : Any]
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.POST.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                self.alertView(title: "网络请求失败")
                return
            }
            
            guard let dateDic = resultDic["data"] as? [String:Any] else {
                return
            }
            guard let contentArray = dateDic["content"] as? [[String:Any]] else {
                return
            }
            
            for content in contentArray {
                let doctor = Doctor(dict: content)
                self.doctors.append(doctor)
            }
             self.doctorTV.reloadData()
        }
    }
}
