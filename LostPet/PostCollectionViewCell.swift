//
//  PostCollectionViewCell.swift
//  LostPet
//
//  Created by Eris on 2017/8/2.
//  Copyright © 2017年 eris. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var petPhoto: UIImageView!
    @IBOutlet weak var petStatus: UILabel!
    
    var pet :Pet?{
        didSet{
            petStatus.text = pet?.name
        }
    }
}
