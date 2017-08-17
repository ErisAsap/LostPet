//
//  Pet.swift
//  LostPet
//
//  Created by Eris on 2017/8/4.
//  Copyright © 2017年 eris. All rights reserved.
//

import Alamofire
import UIKit
//import ObjectMapper

enum PostType{
    case lost
    case found
}

//Pet類型宣告
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
    
    var mainPhoto : String?
    var postType : PostType
    var text :String {
        return   "\(chip ?? "")\(name ?? "")\(type ?? "")\(sex ?? "")\(breed ?? "")\(color ?? "")\(looks ?? "")\(feature ?? "")\(lastSeenTime ?? "")\(lastSeenAddr ?? "")\(contactName ?? "")\(contactNumber ?? "")\(contactEmail ?? "")"        
    }
}

// 在閉包前面加上 @escaping 的話 會讓這個原本應該要求閉包的位置 變成 要求一個參數值的神奇閉包


//在這個func尾端 用completion(lostPetsOrigin)來回傳在此閉包當中創造好的

//MARK: 取得政府URL上的資料，轉換成Pet物件儲存至LostPets陣列中
//之後是這樣呼叫他：
//Pet.getLostPetsArrayWithAlamofire { (lostPetsOrigin) in
//    self.lostPetsOrigin = lostPetsOrigin
//    self.updateSelectedType(nil)
//    self.updatePost()
//}
//

extension Pet{
    static func getLostPetsArrayWithAlamofire(completion: @escaping ([Pet]) -> Void ){
        DispatchQueue.global(qos:.userInitiated).async {
    
    var lostPetsOrigin = [Pet]()
        
    
    Alamofire.request(lostPetJsonURL).responseJSON { response in
        print("Result: \(response.result)") // 格式化結果：成功或失敗
        //確認取得資料成功
        guard response.result.isSuccess else{
            let errorMessage = response.result.error?.localizedDescription
            print(errorMessage!)
            return
        }
        
        guard let jsonObject = response.result.value as? [[String:String?]] else {
            print("JSON format to object error")
            return
        }
        print("已將json轉成字典物件")

        
        lostPetsOrigin = jsonObject.map{
            Pet(chip: $0["晶片號碼"] as? String, name: $0["寵物名"] as? String, type: $0["寵物別"] as? String, sex: $0["性別"] as? String, breed: $0["品種"] as? String, color: $0["毛色"] as? String, looks: $0["外觀"] as? String, feature: $0["特徵"] as? String, lastSeenTime: $0["遺失時間"] as? String, lastSeenAddr: $0["遺失地點"] as? String, contactName: $0["飼主姓名"] as? String, contactNumber: $0["連絡電話"] as? String, contactEmail: $0["Email"] as? String, mainPhoto: $0["主要照片"] as? String, postType: .lost)
        }
        
        print(lostPetsOrigin.filter{$0.chip != nil && $0.chip != "" }.count)//3000
          print(lostPetsOrigin.filter{$0.sex != nil && $0.sex != "" }.count)//2999
        print(lostPetsOrigin.filter{$0.contactName != nil && $0.contactName != "" }.count)//3000
            print(lostPetsOrigin.filter{$0.contactNumber != nil && $0.contactNumber != "" }.count)//2992
        
        print(lostPetsOrigin.filter{$0.type != nil && $0.type != "" }.count)//2999

        print(lostPetsOrigin.filter{$0.lastSeenTime != nil && $0.lastSeenTime != "" }.count)//2998
        print(lostPetsOrigin.filter{$0.breed != nil && $0.breed != "" }.count)//2998
        print(lostPetsOrigin.filter{$0.looks != nil && $0.looks != "" }.count)//2994

        
        
        print(lostPetsOrigin.filter{$0.lastSeenAddr != nil && $0.lastSeenAddr != "" }.count)//2593
        print(lostPetsOrigin.filter{$0.name != nil && $0.name != "" }.count)//2338
        print(lostPetsOrigin.filter{$0.color != nil && $0.color != "" }.count)//1966
        print(lostPetsOrigin.filter{$0.feature != nil && $0.feature != "" }.count)//1483
        print(lostPetsOrigin.filter{$0.contactEmail != nil && $0.contactEmail != "" }.count) // 0
        print("已將json字典轉成Pet物件")
        
        //將虛擬照片名指派給遺失動物陣列
        let fakeCatPhotoTotalNumber = 7
        let fakeDogPhotoTotalNumber = 11
        var index = 0
        while index < lostPetsOrigin.count {
            //                print("start\(index)")
            if let type = lostPetsOrigin[index].type, type.contains("貓") {
                let photoNumber = String(format:"%.2d",(index%fakeCatPhotoTotalNumber))
                lostPetsOrigin[index].mainPhoto = "cat\(photoNumber).jpg"
                //                    print("cat\(photoNumber)")
            }else if let type = lostPetsOrigin[index].type, type.contains("狗"){
                let photoNumber = String(format:"%.2d",(index%fakeDogPhotoTotalNumber))
                lostPetsOrigin[index].mainPhoto = "dog\(photoNumber).jpg"
                //                    print("dog\(photoNumber)")
            }
            //                print("end\(index)")
            index += 1
        }
        print("測試：第40張假照片名稱是：\(lostPetsOrigin[40].mainPhoto ?? "沒找到照片")")
        print("已將虛擬照片指派給pet物件")
    
        DispatchQueue.main.async {
            completion(lostPetsOrigin)
        }

    }

            
        
        
        //Aoamofire閉包指令結束
    }
    //取得資料func結束
}


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




