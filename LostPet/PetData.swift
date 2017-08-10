//
//  PetData.swift
//  LostPet
//
//  Created by Eris on 2017/8/10.
//  Copyright © 2017年 eris. All rights reserved.
//

import Foundation

//取得政府公開遺失資訊的URL
let lostPetJsonURL = "http://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=127"
//let lostPetJsonURL = "https://lostpet-8d29a.firebaseio.com/json" firebase的DB連結，以後要做即時DB時使用
//因為不是https已經去改了plist裡面的設定

//寵物帳貼的名稱，現在基本上都是照片名
var postData = [
    ["pet00","pet01","pet02","pet03","pet04","pet05","pet06","pet07","pet08","pet09","pet10"],
    ["pet11","pet12","pet13","pet14","pet15"],
    ["pet16","pet17","pet18"]
]

//寵物首張照片 對上該寵物其他照片的字典
let petPhotosDic = [
    "pet00":["pet00-0","pet00-1","pet00-2","pet00-3","pet00-4"],
    "pet01":["pet01-0","pet01-1","pet01-2","pet01-3","pet01-4","pet01-5"]
]
