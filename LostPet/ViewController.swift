//
//  ViewController.swift
//  LostPet
//
//  Created by Eris & Richard on 2017/8/2.
//  Copyright © 2017年 eris & richard. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    var selectedPet: String?

    let postCell = "PostCell"


    //Firebase的設定
    var ref: DatabaseReference!
    /*
     在剛開始的時候是讀寫設定都只開放給授權使用者，但是在還沒建置使用這資訊的時候，可以在使用資料庫的規則裡面去把它改成:true，所有人都可讀可寫，之後一定要記得寫回來
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        //getLostPetData()
        //testFirebaseUsage()
        getLostPetObject()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
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
    
    
    
    
    
    //MARK: 集合視圖的建置
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell, for: indexPath) as! PostCollectionViewCell
        cell.petStatus.text = postData[indexPath.section][indexPath.row]
        cell.petPhoto.image = UIImage(named: "\(postData[indexPath.section][indexPath.row]).jpg")

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

