//
//  ViewController.swift
//  LostPet
//
//  Created by Eris & Richard on 2017/8/2.
//  Copyright © 2017年 eris & richard. All rights reserved.
//

import UIKit
import Firebase
//import ObjectMapper
import Alamofire
//import AlamofireObjectMapper


class PostViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catIcon: UIButton!
    @IBOutlet weak var dogIcon: UIButton!
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    var selectedPet: String?
    let postCell = "PostCell"
    var lostPets = [Pet]()
    var filteredPets = [Pet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        getLostPetsArrayWithAlamofire()
        
        //改變顏色
        let origImage = UIImage(named: "catStroke")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        catIcon.setImage(tintedImage, for: .normal)
        catIcon.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        //testFirebaseUsage()
        //getLostPetObjectWithSwift3()
        //getLostPetsObjectWithAlamofireObjectMapper() //記得打開import AlamofireObjectMapper
    }
    
    @IBAction func sortByCat(_ sender: Any) {
        print("start sortByCat")
        catIcon.isSelected = !catIcon.isSelected
        updatePost()
    }
    
    @IBAction func sortByDog(_ sender: Any) {
        print("start sortByDog")
        dogIcon.isSelected = !dogIcon.isSelected
        updatePost()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("start searching")
        guard let keywords = searchBar.text else {return}
        if keywords == ""{
            filteredPets = lostPets
            updatePost()
            return
        }
        print(keywords)
        filteredPets = filteredPets.filter{($0.lastSeenAddr?.lowercased() ?? "").contains(keywords.lowercased())}
        updatePost()
    }

    
    func updatePost(){
        print("start updating Post")
        var newList = filteredPets
        if !dogIcon.isSelected{
            print("dog is not selected")
            newList = newList.filter{$0.type != "狗"}
            print("dog been filtered out from list")
        }
        if !catIcon.isSelected{
            print("cat is not selected")
            newList = newList.filter{$0.type != "貓"}
            print("cat been filtered out from list")
        }
        filteredPets = newList
        print("start reload View")
        self.postCollectionView.reloadData()
    }
    
    //MARK: 取得政府URL上的資料，轉換成Pet物件儲存至LostPets陣列中
    func getLostPetsArrayWithAlamofire(){
        
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
            

            self.lostPets = jsonObject[0..<500].map{
                Pet(chip: $0["晶片號碼"] as? String, name: $0["寵物名"] as? String, type: $0["寵物別"] as? String, sex: $0["性別"] as? String, breed: $0["品種"] as? String, color: $0["毛色"] as? String, looks: $0["外觀"] as? String, feature: $0["特徵"] as? String, lastSeenTime: $0["遺失時間"] as? String, lastSeenAddr: $0["遺失地點"] as? String, contactName: $0["飼主姓名"] as? String, contactNumber: $0["連絡電話"] as? String, contactEmail: $0["Email"] as? String, mainPhoto: $0["主要照片"] as? String)
            }
//            print(self.lostPets[0..<2])
            self.filteredPets = self.lostPets
            print("new data for post have built")
            self.updatePost()
            //Aoamofire閉包指令結束
        }
        //取得資料func結束
    }
    
    //MARK: 集合視圖的建置
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredPets.count > 0{
            return filteredPets.count}
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell, for: indexPath) as! PostCollectionViewCell
        if filteredPets.count > 0{
        let pet = filteredPets[indexPath.row]
        cell.pet = pet}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPet = postData[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "SelectPet", sender: nil)
    }

        //MARK: 頁面控制
        //前往動物資訊頁
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SelectPet"{
                let petInfoPage = segue.destination as! PetDetailViewController
                petInfoPage.selectedPet = self.selectedPet
            }
        }
        
}


//    //MARK: 集合視圖的建置
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return postData.count
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return postData[section].count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let pet = filteredPets[indexPath.row]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell, for: indexPath) as! PostCollectionViewCell
//        cell.petStatus.text = postData[indexPath.section][indexPath.row]
//        cell.petPhoto.image = UIImage(named: "\(postData[indexPath.section][indexPath.row]).jpg")
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedPet = postData[indexPath.section][indexPath.row]
//        performSegue(withIdentifier: "SelectPet", sender: nil)
//    }
    


//Firebase的設定
//var ref: DatabaseReference!
/*
 在剛開始的時候是讀寫設定都只開放給授權使用者，但是在還沒建置使用這資訊的時候，可以在使用資料庫的規則裡面去把它改成:true，所有人都可讀可寫，之後一定要記得寫回來
 */


/*
 //注意：responseJSON函式會以異步方式執行，在結果被傳回來之後才有值，太早用會是空的
 */

//MARK: 用swift3自身語法取得json物件
/*func getLostPetObjectWithSwift3(){
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
 
 
 
 } catch let jsonErr {
 //JSONSerialization 會丟出錯誤我們可自訂常數名稱，並設定出現錯誤時的錯誤敘述
 print("Error serializing json:", jsonErr)
 }
 ///直接取得資訊
 }.resume()
 print(lostPets[0])
 
 }*/

//MARK: 用AlamofireObjectMapper取得物件
//
//    func getLostPetsObjectWithAlamofireObjectMapper(){
//        Alamofire.request(lostPetJsonURL).responseArray { (response:DataResponse<[Pet]>) in
//            guard let result = response.result.value else{
//                print("error: can't get url json value")
//                return
//            }
//            lostPets = result
//            print(lostPets[0])
//        }
//    }

//testFirebaseUsage() firebase的DB的基本寫入方法的測試func

/*func testFirebaseUsage(){
 print("start changing firbase DB")
 ref = Database.database().reference()
 
 //創造或複寫其中一個node底下的Key:Value資料: node.setValue(""),用這個方式的話.setValue所以在child("")後面的東西都會被取代
 self.ref.child("users").child("happykcul").setValue(["username":"ErisAsap","age":"unkown","birthday":"unkown"])
 //錯誤示範：例底下這句，就會覆寫happykcul段下的所有資料使上面下面三筆資料都只被這一筆資料覆寫
 //        self.ref.child("users").child("happykcul").setValue(["birthday":"0608"])
 
 //創造或更新其中一個key下的Value: birthday:0608
 self.ref.child("users").child("happykcul").child("birthday").setValue("0608")
 //目標位置的簡寫方式
 self.ref.child("users").child("fafalee").setValue("") //這樣寫就可以清空該node下的資料
 self.ref.child("users/fafalee/username").setValue("FaFa") //會直接覆蓋過原本 fafalee: "" 變成 fafalee->username:FaFa
 self.ref.child("users/fafalee/birthday").setValue("1010")
 
 print("finish changing firbase DB")
 }
 */



//TODO: 讓圖片大小在任何手機上都可以自動抓取呈現合適的滿版大小
//TODO: PostID設定的方式會表達基本的地區和時間，因為搜尋的時候主要是依照這個來搜尋，並且會有一個關聯的PetID值
//主要頁面的PostCell資訊要包括哪一些？
//TODO: 要如何加速根據GPS位置的範圍搜尋？計算比較複雜還不太懂，之後再研究。
//TODO: 所有的Pet的主要照片按照一定的規範命名，照理來說可以加速搜尋排列的速度，使用照片名字快速篩選，目前的想法比較簡單事：遺失日期-張貼類型-物種-順序編號，例如: 20170801LostDog001,20170726FoundCat001,20170726FoundCat002。這樣在排序照片的時候只要按照照片名字的日期排列，篩選的時候也可以快速使用照片名字篩選。
//TODO: 是否可以直接使用照片的名字當作PetID，這樣在點擊照片時可以直接根據圖片名稱即可呼叫出對應的PetID內詳細資訊
//TOTHINK: 或許只要在採集json資訊和使用者輸入資訊的時候在命名上下小功夫，就能在大量資料處理的時候提升處理效率



