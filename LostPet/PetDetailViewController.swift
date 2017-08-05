//
//  PetDetailViewController.swift
//  LostPet
//
//  Created by Eris & Richard on 2017/8/3.
//  Copyright © 2017年 eris & richar. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {

    @IBOutlet weak var petPhotoScrollView: UIScrollView!
    var selectedNumber : Int!
    @IBOutlet weak var txtPetInfo: UITextView!{
        didSet{
            if selectedNumber != nil {
                var name = lostPets[selectedNumber].name
                if name == ""{ name = "失主尚未提供" }
                txtPetInfo.text  = "寵物姓名:\(name!)"
            }
        }
    }
    
    var previousPage: ViewController?
    

    var selectedPet : String!{
        didSet{
            //FIXME: 這樣只是把被選擇的照片名字字串的後兩個字抓出來而已，這裡之後要用其他比較組織的方式處理
            let lastEmptyChar =  selectedPet.endIndex
            let firstFromRight = selectedPet.index(lastEmptyChar, offsetBy: -1)
            let secondFromRight = selectedPet.index(lastEmptyChar, offsetBy: -2)
            if let number = Int(selectedPet[secondFromRight...firstFromRight]){
            print(number)
            selectedNumber = number
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PetDetailPageDidLoad")
        setUpPhotosScrollView()
    //End of viewDidLoad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //頁面控制:回到上一面
    @IBAction func backToPreviousPage(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
        
    //頁面佈置:寵物照片展示區
    private func setUpPhotosScrollView(){
        
        //確定有照片
        guard let petPhotos = petPhotosDic[selectedPet!] else {
            print("failed to get selectedPet")
            return }
        
        //設定Scroll Veiw大小
        petPhotoScrollView.contentSize.width = petPhotoScrollView.frame.width * CGFloat(petPhotos.count)
        
        //在Scroll View上加上照片
        for itemNumber in 0 ..< petPhotos.count {
        let petPhotoImageView = UIImageView()
        petPhotoImageView.image = UIImage(named: "\(petPhotos[itemNumber]).jpg")
        petPhotoImageView.contentMode = .scaleAspectFit
        let imageStartX = self.petPhotoScrollView.bounds.width * CGFloat(itemNumber)
        petPhotoImageView.frame = CGRect(x: imageStartX, y: 0, width: self.petPhotoScrollView.bounds.width, height: self.petPhotoScrollView.bounds.height)
        petPhotoScrollView.addSubview(petPhotoImageView)
            
        }
    }
    
    
    
//end of class declaration
}



