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

                lastSeenTime.text = self.pet?.lastSeenTime
                typeAndBreed.text = "\(self.pet?.type ?? "") \(self.pet?.breed ?? "")"
                lastSeenAddr.sizeToFit()
                lastSeenAddr.text = self.pet?.lastSeenAddr
                if let photoName = self.pet?.mainPhoto{
                    self.mainPhoto.image = UIImage(named:photoName)
                }
                //這個功能可以讓文字跑到最左上角
        }

    }
}
