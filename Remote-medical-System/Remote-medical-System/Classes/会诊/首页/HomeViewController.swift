//
//  HomeViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/9/29.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    //MARK: -ui控件
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var realnameLable: UILabel!
    @IBOutlet var positionLable: UILabel!
    @IBOutlet var hospitalLable: UILabel!
    @IBOutlet var departmentLable: UILabel!
    @IBOutlet var applyBtn: UIButton!
    
    @IBOutlet weak var oneMore: UIImageView!
    @IBOutlet weak var twoMore: UIImageView!
    @IBOutlet weak var threeMore: UIImageView!
    
    @IBOutlet weak var todayCount: UILabel!
    @IBOutlet weak var ViewCount: UILabel!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var waitView: UILabel!
    
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    
    @IBOutlet weak var oneHeight: NSLayoutConstraint!
    @IBOutlet weak var twoHeight: NSLayoutConstraint!
    @IBOutlet weak var threeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var oneTableView: UITableView!
    @IBOutlet weak var twoTableView: UITableView!
    @IBOutlet weak var threeTableView: UITableView!
    //MARK: -数据
    lazy var viewModels : [MeetingModel] = [MeetingModel]()
    lazy var viewModels2 : [MeetingModel] = [MeetingModel]()
    lazy var viewModels3 : [MeetingModel] = [MeetingModel]()
    
    var one = false
    var two = false
    var three = false
    
    var typePickerView:UIPickerView!
     var alert : UIAlertController!
    var typeSelect : Int?
     var typeArray:Array<String>? = ["视频","普通"]
    //MARK: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        loadViewModel()
        loadViewModel2()
        loadViewModel3()
    }
   
}

//MARK: -界面设计
extension HomeViewController{
    private func initUI(){
        
        oneHeight.constant = 0
        oneTableView.dataSource = self
        oneTableView.delegate = self
        
        twoHeight.constant = 0
        twoTableView.dataSource = self
        twoTableView.delegate = self
        
        threeHeight.constant = 0
        threeTableView.dataSource = self
        threeTableView.delegate = self
        
        if let icon = User.shareInstance.icon, !icon.isEmpty {
            if let iconURL = URL(string : icon)  {
                iconImage.sd_setImage(with: iconURL, completed: nil)
            }
        }
        if let realname = User.shareInstance.realName, !realname.isEmpty {
           realnameLable.text = realname
        }
        if let position = User.shareInstance.prositionalTitle, !position.isEmpty {
            positionLable.text = position
        }
        if let hospital = User.shareInstance.hospital, !hospital.isEmpty {
            hospitalLable.text = hospital
        }
        if let department = User.shareInstance.department, !department.isEmpty {
           departmentLable.text = department
        }
        
        applyBtn.addTarget(self, action: #selector(applyBtnClick),for: .touchUpInside)
        
        oneView.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(oneClick))
        tapGesture1.numberOfTapsRequired = 1
        oneView.addGestureRecognizer(tapGesture1)
        
        twoView.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(twoClick))
        tapGesture2.numberOfTapsRequired = 1
        twoView.addGestureRecognizer(tapGesture2)
       
        threeView.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(threeClick))
        tapGesture3.numberOfTapsRequired = 1
        threeView.addGestureRecognizer(tapGesture3)
    }
}

//MARK: -添加tableView的数据源
extension HomeViewController{
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init(frame: CGRect( x:0, y:0, width:CGFloat(self.view.frame.size.width) , height:30))
        if pickerView == typePickerView {
            label.text = typeArray![row]
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
        }
        return 0
    }
    
    // MARK: UIPickerViewDataSource
    /**
     设置选择框的列数
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == typePickerView {
            return 1
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typePickerView {
            typeSelect = row
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == oneTableView {
        return viewModels.count + 1
        }else if tableView == twoTableView {
            return viewModels2.count
        }else if tableView == threeTableView {
            return viewModels3.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if tableView == oneTableView {
            if indexPath.row == 0 , self.viewModels.count != 0 {
                  return
             }
            
            let sb = UIStoryboard(name: "meetingDetail", bundle: nil)
            let vc1 = sb.instantiateViewController(withIdentifier: "oneView") as! MeetingDetailController
            vc1.viewModel = viewModels[indexPath.row-1]
            self.present(vc1, animated: true, completion: nil)
         }else if tableView == twoTableView {
            let sb = UIStoryboard(name: "meetingDetail", bundle: nil)
            let vc1 = sb.instantiateViewController(withIdentifier: "oneView") as! MeetingDetailController
            vc1.viewModel = viewModels2[indexPath.row]
            self.present(vc1, animated: true, completion: nil)
         }else if tableView == threeTableView {
            let sb = UIStoryboard(name: "meetingDetail", bundle: nil)
            let vc1 = sb.instantiateViewController(withIdentifier: "oneView") as! MeetingDetailController
            vc1.viewModel = viewModels3[indexPath.row]
            self.present(vc1, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == oneTableView {
            if indexPath.row == 0 , self.viewModels.count != 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "oneCell") as? MeetingViewCell else{
                    return UITableViewCell()
                }
                let dformatter = DateFormatter()
                dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dformatter.date(from:  viewModels[viewModels.count-1].meeting.meetingTime!)
            
                let dformatter2 = DateFormatter()
                dformatter2.dateFormat = "yyyy年MM月dd日HH:mm"
                let datestr = dformatter2.string(from: date!)
                let text = "下一会议于"+datestr+"开始，请做好准备。"
                cell.timeLabel.text = text
                cell.isUserInteractionEnabled = false
                return cell
            
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MeetingCell") as? MeetingViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModels[indexPath.row-1]
                cell.selectionStyle = .none
                return cell
            }
         }else if tableView == twoTableView  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "twoCell") as? MeetingViewCell else {
                return UITableViewCell()
            }
             cell.viewModel = viewModels2[indexPath.row]
             cell.selectionStyle = .none
             return cell
        }else if tableView == threeTableView  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "threeCell") as? MeetingViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModels3[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}


//MARK: -事件处理函数
extension HomeViewController{
    @objc func applyBtnClick(){
        alert = UIAlertController(title: "选择会议类型", message: "\n\n\n", preferredStyle: .actionSheet)
        
        let sure = UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel ){ (action:UIAlertAction) in
            if self.typeSelect != nil {
            Meeting.shareInstance.meetingType = self.typeArray?[self.typeSelect!]
            let sb = UIStoryboard(name: "apply", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "applyView1") as! AppyViewController
            self.present(vc, animated: true, completion: nil)
            }
        }
        
        typePickerView = UIPickerView.init(frame: CGRect(x:30,y:10,width:300,height:80))
        typePickerView.delegate = self;
        typePickerView.dataSource = self
        
        alert.view.addSubview(typePickerView)
        alert.addAction(sure)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func oneClick(){
      
         one = !one
        if one {
            if two {
                twoClick()
            }
            if three {
                threeClick()
            }
               loadViewModel()
                oneMore.isHighlighted = true
                self.oneHeight.constant = CGFloat(self.viewModels.count * 100)
                self.twoHeight.constant = 0
                self.threeHeight.constant = 0
        }else{
            oneMore.isHighlighted = false
            oneHeight.constant = 0
            self.twoHeight.constant = 0
            self.threeHeight.constant = 0
        }
    }
   
    @objc func twoClick(){
        two = !two
        if two {
            if one {
                oneClick()
            }
            if three {
                threeClick()
            }
            loadViewModel2()
            twoMore.isHighlighted = true
            self.oneHeight.constant = 0
            self.twoHeight.constant = CGFloat(self.viewModels2.count * 100)
            self.threeHeight.constant = 0
        }else{
            twoMore.isHighlighted = false
            self.oneHeight.constant = 0
            self.twoHeight.constant = 0
            self.threeHeight.constant = 0
        }
        
    }
    
    @objc func threeClick(){
        three = !three
        if three {
            if one {
                oneClick()
            }
            if two{
                twoClick()
            }
            loadViewModel3()
            threeMore.isHighlighted = true
            self.oneHeight.constant = 0
            self.twoHeight.constant = 0
            self.threeHeight.constant = CGFloat(self.viewModels3.count * 100)
        }else{
            threeMore.isHighlighted = false
            self.oneHeight.constant = 0
            self.twoHeight.constant = 0
            self.threeHeight.constant = 0
        }
    }
}


//MARK: -网络请求函数
extension HomeViewController{
    private func loadViewModel(){
        self.getTodayMeeting(doctor_id: User.shareInstance.userid!, finished: { (result, error) in
            self.viewModels.removeAll()
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            guard let dateArray = result!["data"] as? [[String : Any]] else{
                return
            }
            
            for dateDic in dateArray {
                let meetingModel = MeetingModel(dict: dateDic)
                self.viewModels.append(meetingModel)
            }
            if self.todayCount != nil {
                if self.viewModels.count == 0 {
                    if self.todayView != nil {
                        self.todayView.isHidden = true
                    }
                }else{
                    if self.todayView != nil {
                        self.todayView.isHidden = false
                    }
                    self.todayCount.text = "\(self.viewModels.count)"
                }
               
            }
            self.oneTableView.reloadData()
    })
    }
    
    private func loadViewModel2(){
        self.getWaitingMeeting(doctor_id: User.shareInstance.userid!, finished: { (result, error) in
            self.viewModels2.removeAll()
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            guard let sourceDic = result!["data"] as? [String : Any] else{
                return
            }
            
            guard let dateArray = sourceDic["source"] as? [[String : Any]] else{
                return
            }
            
            for dateDic in dateArray {
                let meetingModel = MeetingModel(dict: dateDic)
                self.viewModels2.append(meetingModel)
            }
            if self.ViewCount != nil {
                if self.viewModels2.count == 0 {
                    if self.waitView != nil {
                        self.waitView.isHidden = true
                    }
                }else{
                    if self.waitView != nil {
                        self.waitView.isHidden = false
                    }
                    self.ViewCount.text = "\(self.viewModels2.count)"
                }
                
            }
            self.twoTableView.reloadData()
        })
    }
    
    
    private func loadViewModel3(){
        self.getEndMeeting(doctor_id: User.shareInstance.userid!, finished: { (result, error) in
            self.viewModels3.removeAll()
            if error != nil {
                self.alertView(title: "网络请求失败！")
                return
            }
            
            guard let sourceDic = result!["data"] as? [String : Any] else{
                return
            }
            
            guard let dateArray = sourceDic["source"] as? [[String : Any]] else{
                return
            }
            
            for dateDic in dateArray {
                let meetingModel = MeetingModel(dict: dateDic)
                self.viewModels3.append(meetingModel)
            }
            
            self.threeTableView.reloadData()
        })
    }
    
    
    
    
    func getTodayMeeting(doctor_id : String , finished : @escaping (_ result : [String : Any]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/getearlydate"
        
    NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        let date = Date()
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        let parameters = ["doctor_id" : doctor_id , "date" : datestr]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                finished(nil,error)
                return
            }
            finished(resultDic,error)
        }
    }
    
    
    func getWaitingMeeting(doctor_id : String , finished : @escaping (_ result : [String : Any]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/getapply"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["doctor_id" : doctor_id , "state" : "0" , "pageNum" : "1" ,"pageSize" : "10"]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                finished(nil,error)
                return
            }
            finished(resultDic,error)
        }
    }
    
    func getEndMeeting(doctor_id : String , finished : @escaping (_ result : [String : Any]?, _ error : Error?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "http://39.108.166.49:8080/remote-medical-treatment-sys/meeting/getapply"
        
        NetworkTools.shareInstance.requestSerializer.setValue(User.shareInstance.accesstoken!, forHTTPHeaderField: "accesstoken")
        // 2.获取请求的参数
        
        let parameters = ["doctor_id" : doctor_id , "state" : "3" , "pageNum" : "1" ,"pageSize" : "10"]
        
        // 3.发送网络请求
        NetworkTools.shareInstance.request(method: RequestType.GET.rawValue, url: urlString, parameters: parameters) { (result, error) ->() in
            guard let resultDic = result as? [String : Any] else{
                finished(nil,error)
                return
            }
            finished(resultDic,error)
        }
    }
    
}

