//
//  PostCollectionViewCell.swift
//  LostPet
//
//  Created by Eris on 2017/8/2.
//  Copyright © 2017年 eris. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var lastSeenTime : UILabel!
    @IBOutlet weak var typeAndBreed : UILabel!
    @IBOutlet weak var lastSeenAddr : UILabel!
    
    var pet :Pet?{
        didSet{
            lastSeenTime.text = pet?.lastSeenTime
            typeAndBreed.text = "\(pet?.type ?? "") \(pet?.breed ?? "")"
            lastSeenAddr.text = pet?.lastSeenAddr
            lastSeenAddr.sizeToFit() //這個功能可以讓文字跑到最左上角
        }
    }
}
