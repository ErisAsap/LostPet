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
var catPhotos = ["cat00",
                 "cat01",
                 "cat02",
                 "cat03",
                 "cat04",
                 "cat05",
                 "cat06"]

var dogPhotos = ["dog00",
                 "dog01",
                 "dog02",
                 "dog03",
                 "dog04",
                 "dog05",
                 "dog06",
                 "dog07",
                 "dog08",
                 "dog09",
                 "dog10",
                 "dog11"]

//寵物帳貼的名稱，現在基本上都是照片名
var postData = [
    ["cat00","cat01","pet02","pet03","pet04","pet05","pet06","pet07","pet08","pet09","pet10"],
    ["pet11","pet12","pet13","pet14","pet15"],
    ["pet16","pet17","pet18"]
]

//寵物首張照片 對上該寵物其他照片的字典
let petPhotosDic = [
    "cat00":["cat00-0","cat00-1","cat00-2","cat00-3","cat00-4"],
    "dog00":["dog00-0","dog00-1","dog00-2","dog00-3","dog00-4","dog00-5"]
]
