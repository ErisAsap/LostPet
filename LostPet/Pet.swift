//
//  Pet.swift
//  LostPet
//
//  Created by Eris on 2017/8/4.
//  Copyright © 2017年 eris. All rights reserved.
//


import Foundation
//import ObjectMapper

struct Pet {
    var chip : String?
    var name : String?
    var type : String?
    var sex : String?
    var breed : String?
    var color : String?
    var looks : String?
    var feature : String?
    var lastSeenTime : String?
    var lastSeenAddr : String?
    var contactName : String?
    var contactNumber : String?
    var contactEmail : String?
}


//MARK: 根據Object Mapper第三方套件標準做的類型宣告
//struct Pet: Mappable{
//    
//    var chip : String?
//    var name : String?
//    var type : String?
//    var sex : String?
//    var breed : String?
//    var color : String?
//    var looks : String?
//    var feature : String?
//    var lastSeenTime : String?
//    var lastSeenAddr : String?
//    var contactName : String?
//    var contactNumber : String?
//    var contactEmail : String?
//    
//    init(map:Map){
//        
//    }
//    
//    mutating func mapping(map: Map) {
//        chip <- map["晶片號碼"]  //晶片是15碼
//        name <- map["寵物名"]
//        type <- map["寵物別"]
//        sex <- map["性別"]
//        breed <- map["品種"]
//        color <- map["毛色"]
//        looks <- map["外觀"]
//        feature <- map["特徵"]
//        lastSeenTime <- map["遺失時間"]
//        lastSeenAddr <- map["遺失地點"]
//        contactName <- map["飼主姓名"]
//        contactNumber <- map["連絡電話"]
//        contactEmail <- map["EMail"]
//    }
//
//}


//Swift3的標準寵物類型宣告，聽說swift4變超簡單
// struct Pet {
// let chip : String
// let name : String
// let type : String
// let sex : String
// let breed : String
// let color : String
// let looks : String
// let feature : String
// let lastSeenTime : String
// let lastSeenAddr : String
// let contactName : String
// let contactNumber : String
// let contactEmail : String
// 
// init(json: [String: Any]) {
// chip = json["晶片號碼"] as? Strin//晶片是15碼
// name = json["寵物名"] as? String
// type = json["寵物別"] as? String
// sex = json["性別"] as? String
// breed = json["品種"] as? String
// color = json["毛色"] as? String
// looks = json["外觀"] as? String
// feature = json["特徵"] as? String
// lastSeenTime = json["遺失時間"] as? String
// lastSeenAddr = json["遺失地點"] as? String
// contactName = json["飼主姓名"] as? String
// contactNumber = json["連絡電話"] as? String
// contactEmail = json["EMail"] as? String
// }
// }




