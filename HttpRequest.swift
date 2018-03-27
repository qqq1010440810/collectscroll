//
//  HttpRequest.swift
//  SwiftProject
//
//  Created by gxfMacBook on 2018/3/12.
//  Copyright © 2018年 gxfMacBook. All rights reserved.
//

import UIKit

class HttpRequest: NSObject {

    /**
     *  网络请求成功闭包:(回调成功结果)
     */
    typealias NetworkSuccess = (_ response:NSDictionary) -> ()
    /**
     *  网络请求失败闭包:(回调失败结果)
     */
    typealias NetworkFailure = (_ error:Error) -> ()

//    Get请求
    class func getWithUrlString(url:String,parameters:[String:Any],success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){
        
        var mutableUrl = url
        if !parameters.isEmpty{
            mutableUrl += "?"
            for (paramekey, paramevalue) in parameters {
                mutableUrl += paramekey
                mutableUrl += "="
                mutableUrl += paramevalue as! String
                mutableUrl += "&"
            }
        }
        let mutableUrlStr =   mutableUrl as NSString
        let urlEnCodestr =   mutableUrlStr.substring(to: mutableUrlStr.length-1)
        let urlEnCode = urlEnCodestr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let urlsession = URLSession.shared
        let urls = URL(string:urlEnCode!)
        let urlRequest = NSMutableURLRequest.init(url: urls! as URL)
        urlRequest.httpMethod = "GET"

        let dataTask  = urlsession.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            if (error == nil)
            {
                failure(error!)
            }else
            {
                let jsonData:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary

                success(jsonData )
            }
        }
        //5.执行任务
        dataTask.resume()
    }
//    Post请求
    class func PostWithUrlString(url:String,parameters:[String:AnyObject],success: @escaping NetworkSuccess, failure: @escaping NetworkFailure){

        //创建会话对象
        let session     = URLSession.shared
        let urlEnCode = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let serUrl      = URL(string:urlEnCode!)
        var request     = URLRequest(url: serUrl!)
        request.httpMethod = "POST"
        let postStr = HttpRequest.init().createPostBody(params:parameters)
        request.httpBody = postStr.data(using: String.Encoding.utf8)
        let dataTask : URLSessionDataTask = session.dataTask(with: request) { (data, respones, error)  -> Void  in
            
            //访问结束
            if(error != nil){
                failure(error!)
            }else{
                let jsonData:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                success(jsonData)
            }
        }
        dataTask.resume()
    }
//修改请求体
    func createPostBody(params:[String:AnyObject]) -> String {
        
        var body : String = "";
        for (key, value) in params {
            let str = "\(key)=\(value)&"
            body = body + str
        }
        if(body.count > 1)
        {
            body = (body as NSString).substring(to: body.count-1)
        }
        return body
    }

    
}

