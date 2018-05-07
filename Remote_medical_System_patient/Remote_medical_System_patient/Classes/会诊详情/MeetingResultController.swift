//
//  MeetingResultController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/12.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class MeetingResultController: BaseViewController {
    
    //MARK: -ui控件
    @IBOutlet weak var judgeLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var improveLabel: UILabel!
    @IBOutlet weak var referralLabel: UILabel!
    @IBOutlet weak var nexttimeLabel: UILabel!
    var chatRoomId : String?
    var userName :String?
    
    var result :Result? {
        didSet{
            guard let result = result else {
                return
            }
        }
    }
    //MARK: -系统回调函数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitUI()
        
        // Do any additional setup after loading the view.
    }
    
    private func InitUI(){
        
        judgeLabel.text = result?.judge
        reasonLabel.text = result?.reason
        adviseLabel.text = result?.advise
        planLabel.text = result?.plan
        improveLabel.text = result?.improve
        referralLabel.text = result?.referral
        nexttimeLabel.text = result?.nexttime
    }
    
    
    
}

