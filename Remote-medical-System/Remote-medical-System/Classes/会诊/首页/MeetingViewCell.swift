//
//  MeetingViewCell.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/9.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class MeetingViewCell: UITableViewCell {
    
   
    @IBOutlet weak var applyLable: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var hospitalLable: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var applytimeLabel: UILabel!
    @IBOutlet weak var meetingtimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let onecolor : UIColor = UIColor(displayP3Red: 7/255, green: 189/255, blue: 54/255, alpha: 0.9)
    private let twocolor : UIColor = UIColor(displayP3Red: 37/255, green: 218/255, blue: 208/255, alpha: 0.9)
    
    var viewModel :MeetingModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            
            //如果是创建者
            if viewModel.applyDoctor.realName == User.shareInstance.realName {
                applyLable.text = "申请"
                applyLable.backgroundColor = onecolor
                discriptionLabel.text = viewModel.meeting.disasterDescription
                let applyedDoctors = viewModel.applyedDoctors
                 var doctorString = ""
                 var hospitalString = ""
                 var departmentString = ""
             
                for applyedDoctor in applyedDoctors {
                    doctorString.append("专家:"+applyedDoctor.realName!+"\n")
                     hospitalString.append(applyedDoctor.hospital!+"\n")
                     departmentString.append(applyedDoctor.department!+"\n")
                }
                  doctorLabel.text = doctorString
                  hospitalLable.text = hospitalString
                  departmentLabel.text = departmentString
                
            }else{
                applyLable.text = "受邀"
                applyLable.backgroundColor = twocolor
                discriptionLabel.text = viewModel.meeting.disasterDescription
                var doctorString = ""
                var hospitalString = ""
                var departmentString = ""
                doctorString.append("专家:"+viewModel.applyDoctor.realName!+"\n")
                hospitalString.append(viewModel.applyDoctor.hospital!+"\n")
                departmentString.append(viewModel.applyDoctor.department!+"\n")
                doctorLabel.text = doctorString
                hospitalLable.text = hospitalString
                departmentLabel.text = departmentString
            }
            applytimeLabel.text = "申请时间："+viewModel.meeting.applyTime!
            meetingtimeLabel.text = "会议时间："+viewModel.meeting.meetingTime!
        }
    }
    
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
