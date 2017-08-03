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
    var previousPage: ViewController?
    var selectedPet : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PetDetailPageDidLoad")
        
        let petPhotosDic = [
        "pet00":["pet00-0","pet00-1","pet00-2","pet00-3","pet00-4"],
        "pet01":["pet01-1","pet01-2","pet01-3","pet01-4","pet01-5"]
        ]
        
        
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //頁面控制:回到上一面
    @IBAction func backToPreviousPage(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
