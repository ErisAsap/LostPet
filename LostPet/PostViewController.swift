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
    
    var selectedPet: Pet?
    let postCell = "PostCell"
    var lostPetsOrigin = [Pet]()
    var currentList = [Pet]()
    var selectedList = [Pet]()
    var currentKeywords : [String]?
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("載入post頁面")
        searchBar.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        
        Pet.getLostPetsArrayWithAlamofire { (lostPetsOrigin) in
            self.lostPetsOrigin = lostPetsOrigin
            self.updateSelectedType(nil)
            self.updatePost()
        }

        //改變顏色
        let origImage = UIImage(named: "catStroke")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        catIcon.setImage(tintedImage, for: .normal)
        catIcon.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        catIcon.isSelected = true
        dogIcon.isSelected = true
        //testFirebaseUsage()
        //getLostPetObjectWithSwift3()
        //getLostPetsObjectWithAlamofireObjectMapper() //記得打開import AlamofireObjectMapper
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: chang Add
        self.navigationController?.isNavigationBarHidden = true
         //根據按鈕按下的方式創造選擇的物件陣列
            //更新頁面
    }

    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("按鈕被選擇，更改圖示")
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func updateSelectedType(_ sender: Any?) {

        print("根據選擇物種篩選新陣列")
        //根據按鈕狀態顯示
        selectedList = lostPetsOrigin.filter{
            let type = $0.type ?? "未知"
            if dogIcon.isSelected && type.contains("狗") ||
                catIcon.isSelected && type.contains("貓"){
                return true
            }else{
                return false
            }
        }
        
        currentList = selectedList
        
        updatePost()
        
        if let key = currentKeywords, key.count != 0 {
            self.updateKeywordsResult()
        }
        
    }
    

    

    

    //Data Searching Function
    //搜尋func只要任何一個key不被包含在目標字串裡就回傳false
    func ifPetMatchAlluserInput(petDescription:String, userInput:[String])->Bool{
        var state = true
        userInput.filter{$0 != ""}.forEach{ keyword in
            if petDescription.lowercased().range(of: keyword) == nil {
                state = false
            }
        }
        return state
    }
    
    func updateKeywordsResult(){
        let keys = currentKeywords ?? [""]
        if keys == [""] {
            currentList = selectedList
        }else {
            print("searching for \(keys)")
            currentList = selectedList.filter{
                ifPetMatchAlluserInput(petDescription: $0.text, userInput: keys)
            }
        }
        updatePost()
    }
    
    func updatePost(){
         //如果按鈕被按 就確認searchbar有沒有keyword，
        // 如有的話就先按照原始清單分類然後搜尋，沒的話就分顯示。
        //如果seachbar被按就拿現在的list來做搜尋顯現，現在的list可直接保留如果searchbar為空就顯現。
        // 離開search bar時，search bar被清空時
        
        print("開始更新post")
        countLabel.text = "共\(currentList.count)筆資料"
        self.postCollectionView.reloadData()
        print("完成更新Post")
    }
    
    
    
    //MARK: searchBar Delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        postCollectionView.allowsSelection = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("start searching")
        postCollectionView.allowsSelection = false
        currentKeywords = searchBar.text?.components(separatedBy: " ")
        print("currentKeywords is \(currentKeywords ?? [""])")
        updateKeywordsResult()
        self.hideKeyboardWhenTappedAround()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        updateSelectedType(nil)
        searchBar.resignFirstResponder()
        self.collectionAllowSelected()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        self.hideKeyboardWhenTappedAround()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
    }
    
    fileprivate func collectionAllowSelected(){
        postCollectionView.allowsSelection = true
    }
    
    
    //MARK: 集合視圖的建置:如果fuilteredPets裡面已經有資料，就將
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentList.count > 0{
            return currentList.count}
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell, for: indexPath) as! PostCollectionViewCell
        if currentList.count > 0{
        let pet = currentList[indexPath.row]
        cell.pet = pet}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPet = currentList[indexPath.row]
        performSegue(withIdentifier: "SelectPet", sender: nil)
    }

        //MARK: 頁面控制
        //前往動物資訊頁
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SelectPet"{
                let petInfoPage = segue.destination as! PetDetailViewController
                petInfoPage.selectedPet = self.selectedPet
                //MARK: chang Add
                petInfoPage.previousPage = self
            }
        }

}   //end of class





extension PostViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        //允許選取在main serial裡
        DispatchQueue.main.async {
            self.collectionAllowSelected()
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



