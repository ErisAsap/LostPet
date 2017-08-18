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
    @IBOutlet weak var txtPetInfo: UITextView!
    var selectedPet : Pet!


    override func viewDidLoad() {
        super.viewDidLoad()
        print("PetDetailPageDidLoad")
        
        //MARK: chang Add
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = selectedPet.name ?? ""
        print("被選擇的寵物 內容:\(selectedPet)")
        
    }  //End of viewDidLoad
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpPhotosScrollView()
    }

    //頁面控制:回到上一面
    @IBAction func backToPreviousPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //presentingViewController?.dismiss(animated: true, completion: nil)
    }
        
    //頁面佈置:寵物照片展示區
    private func setUpPhotosScrollView(){
    
        let petPhotosDic = [
            "cat00.jpg":["cat00-0","cat00-1","cat00-2","cat00-3","cat00-4"],
            "dog00.jpg":["dog00-0","dog00-1","dog00-2","dog00-3","dog00-4","dog00-5"]
        ]
        
        //在Scroll View上加上照片
        guard let petPhotos = petPhotosDic[selectedPet.mainPhoto!] else{
            print("沒找到此寵物的相簿"); return}
        //設定Scroll Veiw大小
        let photosCount = petPhotos.count

        for itemNumber in 0 ..< photosCount {
        let petPhotoImageView = UIImageView()
        petPhotoImageView.image = UIImage(named: "\(petPhotos[itemNumber]).jpg")
        petPhotoImageView.contentMode = .scaleAspectFit
        let imageStartX = self.petPhotoScrollView.frame.width * CGFloat(itemNumber)
        petPhotoImageView.frame = CGRect(x: imageStartX, y: 0, width: self.petPhotoScrollView.frame.width, height: self.petPhotoScrollView.frame.height)
        petPhotoScrollView.contentSize.width =  petPhotoImageView.frame.width * CGFloat(photosCount)
        petPhotoScrollView.addSubview(petPhotoImageView)
        }
    }
} //end of class declaration



