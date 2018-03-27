//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by gxfMacBook on 2018/3/7.
//  Copyright © 2018年 gxfMacBook. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
//    enum CompassPoint {
//        case north
//        case south
//        case east
//        case west
//    }
//
//    var directionToHead = CompassPoint.west
    
//主体的collectionview
    var collection : UICollectionView!
//    头部的collectionview
    var collectionhead : UICollectionView!
    var layoutheader : UICollectionViewFlowLayout!
//    判断是否展开头部的collectview
    var isPut:Bool = false
    
    var _historyOffsetX:CGFloat = 0.0; //js交互使用:记录下开始拖拽时的scrollViewX方向偏移量
    var thisoffsetx:CGFloat = 0.0; //当前的偏移量

    
    var dataList:Array = Array<Any>()

    var headerView:UIView!
    var titleLab:UILabel!

    /// 屏幕的宽
    let SCREENW = UIScreen.main.bounds.size.width
    /// 屏幕的高
    let SCREENH = UIScreen.main.bounds.size.height

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        directionToHead = .east

//        类方法调用
        SecViewController.leifangfa()
        
        headerView = UIView(frame:CGRect(x:0,y:20,width:SCREENW,height:40))
        headerView.backgroundColor = UIColor.yellow;
//        titleLab = UILabel()
//        headerView.addSubview(titleLab)
//        titleLab.frame = CGRect(x: 0, y:0, width: SCREENW, height: 40)
//        titleLab.font = UIFont.systemFont(ofSize: 17)
//        titleLab.textColor = UIColor.black
//        titleLab.textAlignment = NSTextAlignment.center
//        titleLab.text = "333"
        
        layoutheader = UICollectionViewFlowLayout()
        layoutheader.itemSize = CGSize(width:(SCREENW-40)/8,height:40)
        //列间距,行间距,偏移
        layoutheader.minimumInteritemSpacing = 0
        layoutheader.minimumLineSpacing = 0
        layoutheader.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layoutheader.scrollDirection = UICollectionViewScrollDirection.horizontal;
        collectionhead = UICollectionView.init(frame:CGRect(x:0,y:0,width: SCREENW-40, height: 40), collectionViewLayout: layoutheader)
        collectionhead.tag = 1000000
        collectionhead.delegate = self
        collectionhead.dataSource = self;
        //注册一个cell
        collectionhead!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier:"HotCell")
        collectionhead.backgroundColor = UIColor.white
        headerView.addSubview(collectionhead!)
        collectionhead.isPagingEnabled = false

        let loginbtn = UIButton(type:UIButtonType.custom)
        loginbtn.frame = CGRect(x:SCREENW-40,y:0,width:40, height: 40)
        headerView.addSubview(loginbtn)
        loginbtn.backgroundColor = UIColor.red
        loginbtn.addTarget(self, action: #selector(loinact(_:)), for: UIControlEvents.touchUpInside)

        self.view.addSubview(headerView)

        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:SCREENW,height:SCREENH)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;

        collection = UICollectionView.init(frame:CGRect(x:0,y:60,width: SCREENW, height: SCREENH), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self;
        //注册一个cell
        collection.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier:"HotCell")
        collection.backgroundColor = UIColor.white
        self.view.addSubview(collection!)
        collection.isPagingEnabled = true
        savedata()
        // Do any additional setup after loading the view.
    }

    @objc func loinact(_ sender:UIButton){
        if !isPut{
            headerView.frame = CGRect(x:0,y:20,width: SCREENW, height: 220)
            collectionhead.frame = CGRect(x:0,y:0,width: SCREENW-40, height: 200)
            layoutheader.scrollDirection = UICollectionViewScrollDirection.vertical;
            self.view .bringSubview(toFront: headerView)
        }else{
            headerView.frame = CGRect(x:0,y:20,width: SCREENW, height: 40)
            collectionhead.frame = CGRect(x:0,y:0,width: SCREENW-40, height: 40)
            layoutheader.scrollDirection = UICollectionViewScrollDirection.horizontal;
           
            let page =  thisoffsetx / SCREENW + 0.5; //整数
            let intNumber = Int(page)
            if intNumber>7{
                collectionhead.setContentOffset(CGPoint(x:(SCREENW-40)/8*CGFloat(intNumber-7),y:0), animated: true)
            }
        }
        isPut = !isPut
    }
    
    func savedata() {
//        MBProgressHUD.showAdded(to: self.view, animated: true)
//        MBProgressHUD.showMessag("获取数据", to: self.view)
//
//        let parames =  ["s_id": "99-37-11321836-88967-69-1147-6195-2815", "nursery_id": "2517F31E5752D7F655DCE5674231A0E761945A1105952DB4B02959BEBD8D6A13"]
//        HttpRequest.PostWithUrlString(url: "https://pss.8huasheng.com/rest/appfunc/get/bychildid3", parameters: parames as [String : AnyObject], success: { (result) in
//            let dict = result
//            print(dict);
//
//            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//
//        }) { (error) in
//
//            print(error);
//
//        }
        
        let arr1 = ["1","2","3","4","5","6","7","8","9"]
        let arr2 = ["10","11","12"]
        dataList = arr1+arr2
        collection?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    collect代理方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 20
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath) as! HomeCollectionViewCell
        if collectionView.tag == 1000000{
            cell.backgroundColor = UIColor.blue
        }else{
            cell.backgroundColor = UIColor.orange
        }

        cell.labstring = dataList[indexPath.item] as! String
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1000000{
            collection.setContentOffset(CGPoint(x:SCREENW*CGFloat(indexPath.row),y:0), animated: true)
        }else{
            let ser = SecViewController();
            self.present(ser, animated: true, completion: nil)
        }
    }
    
    func postValueToUpPage(str: String) {

        let arr1 = ["5","5","5"]
        let arr2 = ["6","6","6"]
        dataList = arr1+arr2
        collection?.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        _historyOffsetX = scrollView.contentOffset.x;

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.tag != 1000000{
            if scrollView.contentOffset.x>_historyOffsetX{
                let pagewill = scrollView.contentOffset.x / SCREENW +  0.999999; //整数
                let intNumberwill = Int(pagewill)
                print("bbbbbbbbbb\(intNumberwill)")
            }else{
                let pagewill = scrollView.contentOffset.x / SCREENW; //整数
                let intNumberwill = Int(pagewill)
                print("bbbbbbbbbb\(intNumberwill)")
            }
            let page = scrollView.contentOffset.x / SCREENW + 0.5; //整数
            let intNumber = Int(page)
            print("\(scrollView.contentOffset.x)aaaaaaaa\(intNumber)")
            //        titleLab.text = "\(intNumber)"
            thisoffsetx = scrollView.contentOffset.x
            if intNumber >= 4 && intNumber < dataList.count-3{
                if !isPut{
                    collectionhead.setContentOffset(CGPoint(x:(SCREENW-40)/8*CGFloat(intNumber-4),y:0), animated: true)
                }
            }
        }
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
