//
//  ViewController.swift
//  LostPet
//
//  Created by Eris & Richard on 2017/8/2.
//  Copyright © 2017年 eris & richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var selectedPet: String?
    var postData = [
        ["pet00","pet01","pet02","pet03","pet04","pet05","pet06","pet07","pet08","pet09","pet10"],
        ["pet11","pet12","pet13","pet14","pet15"],
        ["pet16","pet17","pet18"]
    ]
    
    let postCell = "PostCell"
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    //TODO: 讓圖片大小在任何手機上都可以自動抓取呈現合適的滿版大小
    //TODO: PostID設定的方式會表達基本的地區和時間，因為搜尋的時候主要是依照這個來搜尋，並且會有一個關聯的PetID值
    //主要頁面的PostCell資訊要包括哪一些？
    //TODO: 要如何加速根據GPS位置的範圍搜尋？計算比較複雜還不太懂，之後再研究。
    //TODO: 所有的Pet的主要照片按照一定的規範命名，照理來說可以加速搜尋排列的速度，使用照片名字快速篩選，目前的想法比較簡單事：遺失日期-張貼類型-物種-順序編號，例如: 20170801LostDog001,20170726FoundCat001,20170726FoundCat002。這樣在排序照片的時候只要按照照片名字的日期排列，篩選的時候也可以快速使用照片名字篩選。
    //TODO: 是否可以直接使用照片的名字當作PetID，這樣在點擊照片時可以直接根據圖片名稱即可呼叫出對應的PetID內詳細資訊
    //THINK: 只要在採集json資訊和使用者輸入資訊的時候在命名上下小功夫，或許就能在大量資料處理的時候提升處理效率
    
    //MARK: UICollectionView
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
        performSegue(withIdentifier: "SelectPet", sender: selectedPet)
    }
    
    //Change Page to Pet Detail
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        let petInfoPage = storyboard?.instantiateViewController(withIdentifier: "PetDetailViewController") as! PetDetailViewController
        petInfoPage.selectedPet = sender as? String
        present(petInfoPage, animated: true, completion: nil)
        self.selectedPet = petInfoPage.selectedPet ?? "unknown pet"
        print("performsegue with \(self.selectedPet!) selected")
    }

}

