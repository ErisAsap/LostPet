//
//  ViewController.swift
//  LostPet
//
//  Created by Eris on 2017/8/2.
//  Copyright © 2017年 eris. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var postData = [
    ["pet1","pet2","pet3","pet4","pet5","pet6","pet7","pet8","pet9","pet10"],
    ["pet11","pet12","pet13","pet14","pet15"],
    ["pet16","pet17","pet18"]
    ]
    
    let postCell = "PostCell"
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UICollectionView
    //TODO: 讓圖片大小在任何手機上都可以自動抓取呈現合適的滿版大小
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

}

