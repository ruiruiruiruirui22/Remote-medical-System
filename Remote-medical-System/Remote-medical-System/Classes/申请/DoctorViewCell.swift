//
//  DoctorViewCell.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/14.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit
import SDWebImage

class DoctorViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var cellphoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var doctor :Doctor? {
      didSet{
            if doctor?.icon != nil {
                if let url = URL(string : (doctor?.icon)!) {
                    iconImage.sd_setImage(with:url, completed: nil)
                }
            }
            realNameLabel.text = doctor?.realName
            hospitalLabel.text = doctor?.hospital
            departmentLabel.text = doctor?.department
            cellphoneLabel.text = doctor?.cellphone
            emailLabel.text = doctor?.email
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
