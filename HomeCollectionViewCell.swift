//
//  HomeCollectionViewCell.swift
//  SwiftProject
//
//  Created by gxfMacBook on 2018/3/7.
//  Copyright © 2018年 gxfMacBook. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    var label = UILabel()
    var labstring:String = String(){
        didSet{
            label.text = labstring
            label.textAlignment = .center
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.init(frame: self.bounds)
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
