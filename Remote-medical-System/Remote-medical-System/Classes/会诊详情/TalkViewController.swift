//
//  TalkViewController.swift
//  Remote-medical-System
//
//  Created by j on 2017/10/19.
//  Copyright © 2017年 newfolder. All rights reserved.
//

import UIKit

class TalkViewController: BaseViewController {

    @IBOutlet weak var talkTableView: UIWebView!
    var userName : String?
    var chatRoomId : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userName != nil , chatRoomId != nil {
            let urlString = "http://119.29.247.127/webIm/test.html?userName=\(userName!)&chatRoomId=\(chatRoomId!)"
            guard let url = URL(string : urlString) else {
                return
            }
            let urlRequest = URLRequest.init(url: url)
            talkTableView.loadRequest(urlRequest)
        }
    }
}
