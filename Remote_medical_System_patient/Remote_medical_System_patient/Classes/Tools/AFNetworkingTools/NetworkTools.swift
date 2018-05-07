///Volumes/Samsung-m3/代码/DSWB/DSWB/DSWB/Classes/Tools
//  NetworkTools.swift
//  DSWB
//
//  Created by j on 2017/9/11.
//  Copyright © 2017年 杨晋. All rights reserved.
//

import AFNetworking

enum RequestType :String{
    case GET="GET"
    case POST="POST"
}

enum RequestURL :String{
    case PREFIX="http://39.108.166.49:8080/remote-medical-treatment-sys"
}


class NetworkTools: AFHTTPSessionManager {
    static let shareInstance: NetworkTools={
        let tools=NetworkTools();
        tools.requestSerializer = AFJSONRequestSerializer.init()
        tools.responseSerializer = AFJSONResponseSerializer.init()
         return tools
    }()
}

extension NetworkTools{
    
    
    func request( method: String , url : String , parameters: [String : Any] ,finished : @escaping (_ result: Any?,_ error :Error?) ->()){
        
        let successCallBack={ (task : URLSessionDataTask?, result:Any?) -> Void in
            finished(result,nil)
        }
        
        let failureCallBack={ (task: URLSessionDataTask?, error: Error)->Void in
            finished(nil,error)
        }
        
        if method=="GET" {
            get(url, parameters: parameters, success:successCallBack  ,failure :failureCallBack)
        }else{
            post(url, parameters: parameters, success: successCallBack,failure :failureCallBack)
        }
        
        
    }
    
    

}




