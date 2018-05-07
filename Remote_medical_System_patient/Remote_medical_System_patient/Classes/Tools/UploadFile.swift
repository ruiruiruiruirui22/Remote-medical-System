// import UIKit
//
//
// class UploadFile {
//
//    // 拼接字符串
//
//    let boundaryStr = "--"  // 分隔字符串
//
//    let randomIDStr = "----------thinkyouitcast---------"  //本次上传标示字符串
//
//    let uploadID = "uploadFile" // 上传(php)脚本中，接收文件字段
//
//
//
//    private func topStringWithMimeType(mimeType:String, uploadFile: String)->String{
//
//        let strM = NSMutableString()
//
//        strM.append("\(boundaryStr)\(randomIDStr)\n")
//
//        strM.append("Content-Disposition: form-data; name=\"\(uploadID)\"; filename=\"\(uploadFile)\"\n")
//
//        strM.append("Content-Type:\(mimeType)\n\n")
//
//        return strM as String
//
//    }
//
//
//
//    private func bottomString()->String{
//
//        let strM = NSMutableString()
//
//        strM.append("\(boundaryStr)\(randomIDStr)\n")
//
//        strM.append("Content-Disposition: form-data; name=\"submit\"\n\n")
//
//        strM.append("Submit\n")
//
//        strM.append("\(boundaryStr)\(randomIDStr)--\n")
//
//        return strM as String
//
//    }
//
//
//
//    //MARK: 上传文件
//
//    func uploadFileWithURL(url: NSURL, data: NSData, completionHandler handler:@escaping ((_ response:URLResponse?, _ data: NSData?, _ connetionError: NSError?) -> Void)){
//
//        // 1> 数据体
//
//        let topStr: NSString = self.topStringWithMimeType(mimeType: "Application/dcm", uploadFile:"/Users/jj/Desktop/assets/assets/img/icon/ColorDcm/彩色DCM/I0000060.dcm") as NSString
//
//        let bottomStr: NSString = self.bottomString() as NSString
//
//
//
//        let dataM = NSMutableData()
//
//        dataM.append(topStr.data(using: String.Encoding.utf8.rawValue)!)
//
//        dataM.append(data as Data)
//
//        dataM.append(bottomStr.data(using: String.Encoding.utf8.rawValue)!)
//
//
//
//        // 1.Request
//
//        let request = NSMutableURLRequest(url: url as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 2.0)
//
//
//
//        // dataM出了作用域就会被释放,因此不用copy
//        request.httpBody = dataM as Data
//
//
//
//        // 2> 设置Request的头属性
//
//        request.httpMethod = "POST"
//
//
//
//        // 3> 设置Content-Length
//
//        let strLength = "\(data.length)"
//
//        request.setValue(strLength, forHTTPHeaderField:"Content-Length")
//
//
//
//        // 4> 设置Content-Type
//
//        let strContentType = "multipart/form-data; boundary=\(randomIDStr)"
//
//        request.setValue(strContentType, forHTTPHeaderField:"Content-Type")
//
//
//
//        // 3> 连接服务器发送请求
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) ->Void in
//
//            handler(response, data as! NSData, error as? NSError)
//
//        }
//
//
//
//        task.resume()
//
//
//
//        //@available(iOS, introduced=5.0, deprecated=9.0, message="Use [NSURLSession dataTaskWithRequest:completionHandler:] (see NSURLSession.h")
//
//        //        NSURLConnection.sendAsynchronousRequest(<#T##request: NSURLRequest##NSURLRequest#>, queue: <#T##NSOperationQueue#>, completionHandler: <#T##(NSURLResponse?, NSData?, NSError?) -> Void#>)
//
//    }
//
// }
// // 测试
//
// func test(){
//
//
//
//    let url = ("http://39.108.166.49:8080/remote-medical-treatment-sys/upload/cloud")
//    uirepre
//   let file = UIImagePNGRepresentation
//
//
//
//    UploadFile().uploadFileWithURL(url: NSURL(string: url)!, data: imageData! as NSData) { (response, data, error) ->Void in
//
//        let str = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//
//        print("\(str)")
//
//    }
//
//
//
// }

