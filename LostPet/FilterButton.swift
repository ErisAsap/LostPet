//
//  FilterButton.swift
//  LostPet
//
//  Created by Eris on 2017/8/10.
//  Copyright © 2017年 eris. All rights reserved.
//

import UIKit

class FilterButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2   //除以UIScreen.main.nativeScale就會變成pixel超細，最小點
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
        let buttonColor: UIColor = isEnabled ? (titleLabel?.textColor)! : UIColor.lightGray
        layer.borderColor = isSelected ? UIColor.clear.cgColor : buttonColor.cgColor
        layer.backgroundColor = isSelected ? buttonColor.cgColor : UIColor.clear.cgColor

        
//        let origImage = UIImage(named: "imageName")
//        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//        btn.setImage(tintedImage, forState: .normal)
//        btn.tintColor = .redColor

    }
    
}
