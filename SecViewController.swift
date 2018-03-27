//
//  SecViewController.swift
//  SwiftProject
//
//  Created by gxfMacBook on 2018/3/8.
//  Copyright © 2018年 gxfMacBook. All rights reserved.
//

import UIKit
import JavaScriptCore
//protocol LTDelegate: NSObjectProtocol {
//    func postValueToUpPage(str: String)
//}
//

@objc protocol VideoJsDelegate:JSExport {
    func playLog(videoId:String)
    func existsCollectVideo(collectId:String, _ handleName:String, _ typeStr:String)
}

@objc class VideoJsModel: NSObject, VideoJsDelegate {
    var jsContext:JSContext!
    
    func playLog(videoId:String) {
        print(videoId)
    }
    
    func existsCollectVideo(collectId:String, _ handleName:String, _ typeStr:String) {
        // 回调JS里定义的函数
        let handleFunc = self.jsContext.objectForKeyedSubscript(handleName)
        let dict = ["type": typeStr, "status": false] as [String : Any]
        handleFunc?.call(withArguments: [dict])
    }
    
}

class SecViewController: UIViewController,UIWebViewDelegate {

//    weak var delegate: LTDelegate?

    var webView:UIWebView!
    var jsContext:JSContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purple
//        if 1==1
//        {
//            print("3333333")
//        }
//        let gobtn:UIButton = UIButton.init(type:UIButtonType.custom)
//        gobtn.frame = CGRect(x:100,y:100,width:100,height:40)
//        gobtn .setTitle("返回传值", for: UIControlState.normal)
//        gobtn.backgroundColor = UIColor.white
//        gobtn.setTitleColor(UIColor.black, for: UIControlState.normal)
//        gobtn.layer.cornerRadius = 5
//        gobtn.addTarget(self, action:#selector(buttonClick), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(gobtn)
        webView = UIWebView()
        webView.frame = self.view.bounds;
        webView.delegate = self
        self.view .addSubview(webView)
        let url = "http://www.baidu.com"
        let nsUrl = NSURL(string: url)
        webView.loadRequest(URLRequest.init(url: nsUrl! as URL))

        // Do any additional setup after loading the view.
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = VideoJsModel()
        print(self.jsContext)
        model.jsContext = self.jsContext
        // 将jiajiao100app注入到JS中，在JS让jiajiao100app以对象的形式存在
        self.jsContext.setObject(model, forKeyedSubscript: "jiajiao100app" as NSCopying & NSObjectProtocol)
        
        let curUrl = webView.request?.url?.absoluteString  //WebView当前访问页面的链接 可动态注册
        self.jsContext.evaluateScript(curUrl)
//        self.jsContext.evaluateScript(try? String(contentsOfURL: NSURL(string: curUrl!)!, encoding: NSUTF8StringEncoding))
        
        self.jsContext.exceptionHandler = { (context, exception) in
            print("exception：", exception)
        }
    }
//    @objc func buttonClick(button :UIButton){
//
//        delegate?.postValueToUpPage(str: "传值到上一页")
//
//        print("33333")
//
//        self.dismiss(animated: true, completion: nil)
//    }
    
    class func leifangfa(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
