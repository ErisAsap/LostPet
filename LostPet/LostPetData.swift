//
//  LostPetData.swift
//  LostPet
//
//  Created by Eris on 2017/8/5.
//  Copyright © 2017年 eris. All rights reserved.
//

import Foundation
import ObjectMapper
//import Alamofire
//import AlamofireObjectMapper

//取得政府公開遺失資訊的URL
let lostPetJsonURL = "http://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=127"
//let lostPetJsonURL = "https://lostpet-8d29a.firebaseio.com/json" firebase的DB連結，以後要做即時DB時使用

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


var lostPets = [Pet]()


//MARK: 用swift3自身語法取得json物件
func getLostPetObject(){
            ///確保該字串可以以URL形式取得
            guard let url = URL(string: lostPetJsonURL) else {
                print("url error")
                return }

            //MARK:獲取網頁Json資訊
            ///根據URL資訊取得資訊並且處理
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                
                ///確保有資料
                guard let data = data else { return }
                print(data)
                ///用於測試，列印是否成功得到資料
                //                       let dataAsString = String(data: data, encoding: .utf8)
                //                       print(dataAsString)
                ///開始嘗試獲取網頁資訊
                do {
                    //Swift 3 處理多筆json資料的方式
                    guard let json = try JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? [[String:Any]] else{ return }
                    
                    lostPets = Mapper<Pet>().mapArray(JSONArray: json) //這裡使用到ObjectMapper的方法

                    //print(lostPets[0...2]) 這邊測試可以成功抓到數據了
                    
                } catch let jsonErr {
                    //JSONSerialization 會丟出錯誤我們可自訂常數名稱，並設定出現錯誤時的錯誤敘述
                    print("Error serializing json:", jsonErr)
                }
                ///直接取得資訊
                }.resume()

    }


//到這邊已經可以用Alamofire轉出文字檔或是Data檔可是不知道要怎麼把他們轉成Object，還不會用，先註解掉
//如果之後要用記得把這兩句加上去宣告區
//var jsonResultInString : String!
//var jsonResultPets : [[String:String]]!

/*
func getLostPetData(){
    var pets = [Pet]()
    Alamofire.request(lostPetJsonURL).responseJSON { response in
        //因為不是https已經去改了plist裡面的設定
        
        //確認取得資料成功
        guard response.result.isSuccess else{
            let errorMessage = response.result.error?.localizedDescription
            print(errorMessage!)
            return
        }
        print("Result: \(response.result)") // 格式化結果：成功或失敗
        
        //取得整串資料的方式
        guard let jsonData = response.data, let jsonUtf8 = String(data: jsonData, encoding: .utf8)else{
            print("data capture or utf8 encoding error")
            return
        }
        //print("response data return json String:\(jsonUtf8)")
        
        //轉換成陣列
        //print(response.result.value)
        guard let jsonObject = response.result.value as? [Any?] else {
            print("JSON format to object error")
            return
        }
        print(jsonObject[0...2])

        
        
        
        
    //Aoamofire閉包指令結束
    }
    
//取得資料func結束
}
*/

/*Alamofire的基本使用方式
 //Alamofire.request("網址").responseJSON{response in 這個地方有一些屬性可以用}
 //    response.request // 網址
 //    response.response, http url response // 裡面感覺好用資訊有： 下載檔案類型(知道的話方便之後格式轉檔)，下載時間
 //    if let json = response.result.value {
 //    print("JSON: \(json)") // serialized json response 格式化完畢的字串，沒轉檔是看不懂的
 //    }
 //注意：responseJSON函式會以異步方式執行，在結果被傳回來之後才有值，太早用會是空的
 */


