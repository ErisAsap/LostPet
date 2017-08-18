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
    var chip : String? = nil
    var name : String? = nil
    var type : String? = nil
    var sex : String? = nil
    var breed : String? = nil
    var color : String? = nil
    var looks : String? = nil
    var feature : String? = nil
    var lastSeenTime : String? = nil
    var lastSeenAddr : String? = nil
    var contactName : String? = nil
    var contactNumber : String? = nil
    var contactEmail : String? = nil
    
    var mainPhoto : String? = nil
    var postType : PostType = .lost
    var text :String {
        return   "\(chip ?? "")\(name ?? "")\(type ?? "")\(sex ?? "")\(breed ?? "")\(color ?? "")\(looks ?? "")\(feature ?? "")\(lastSeenTime ?? "")\(lastSeenAddr ?? "")\(contactName ?? "")\(contactNumber ?? "")\(contactEmail ?? "")"
    }
}

// MARK: 取得政府URL上JSON的資料轉換成Pet物件，閉包completion，之後在viewDidLoad回調閉包結果來使用
// 在閉包前面加上 @escaping 的話 會讓此閉包可被賦予給閉包外的其他變數，並且在func執行完畢消失時不會和func一起消失
extension Pet{
    //在這個func尾端 用completion來回傳在此閉包當中創造好的Pet陣列給其他類型執行
    static func fetchingResult(completion: @escaping ([Pet]) -> Void ){
        DispatchQueue.global(qos:.userInitiated).async {
            
            //MARK: 接網路上的JSON資料
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
                
                //物件轉換成陣列，
                var lostPetsOrigin = jsonObject.map{
                    Pet(chip: $0["晶片號碼"] as? String, name: $0["寵物名"] as? String, type: $0["寵物別"] as? String, sex: $0["性別"] as? String, breed: $0["品種"] as? String, color: $0["毛色"] as? String, looks: $0["外觀"] as? String, feature: $0["特徵"] as? String, lastSeenTime: $0["遺失時間"] as? String, lastSeenAddr: ($0["遺失地點"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: ""), contactName: $0["飼主姓名"] as? String, contactNumber: $0["連絡電話"] as? String, contactEmail: $0["Email"] as? String, mainPhoto: $0["主要照片"] as? String, postType: .lost)
                    
                }
                
                
                //用晶片號碼當作ID來認是不是該動物
                print(lostPetsOrigin.filter{$0.chip != nil && $0.chip != "" }.count)
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




