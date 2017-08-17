//
//  AddPetViewController.swift
//  LostPet
//
//  Created by Eris on 2017/8/16.
//  Copyright © 2017年 eris. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var breedText: UITextField!
    @IBOutlet weak var looksText: UITextField!
    @IBOutlet weak var colorText: UITextField!
    @IBOutlet weak var featureTextView: UITextView!
    @IBOutlet weak var petImagesView: UIImageView!
    @IBOutlet weak var lastSeenTimeText: UITextField!
    @IBOutlet weak var lastSeenAddrText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var sexText: UITextField!
    @IBOutlet weak var chipText: UITextField!
    @IBOutlet weak var contactNameText: UITextField!
    @IBOutlet weak var contactNumberText: UITextField!
    var completionCallBack : (()->())?
    var pet : Pet?
    
    override func viewDidLoad() {
        
        if let pet = pet {
            typeText.text = pet.type
            breedText.text = pet.breed
            looksText.text = pet.looks
            colorText.text = pet.color
            featureTextView.text = pet.feature
            lastSeenTimeText.text = pet.lastSeenTime
            lastSeenAddrText.text = pet.lastSeenAddr
            nameText.text = pet.name
            sexText.text = pet.sex
            chipText.text = pet.chip
            contactNameText.text = pet.contactName
            contactNumberText.text = pet.contactNumber
            
        }
        
        featureTextView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        featureTextView.addGestureRecognizer(gestureRecognizer)
        
        
    } // Do any additional setup after loading the view.
    
    @IBAction func dismissAddPet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPet(_ sender: Any) {
        
        if pet == nil {
            pet = Pet(chip: nil, name: nil, type: nil, sex: nil, breed: nil, color: nil, looks: nil, feature: nil, lastSeenTime: nil, lastSeenAddr: nil, contactName: nil, contactNumber: nil, contactEmail: nil, mainPhoto: nil, postType: .lost)
        }
        
        pet?.type = typeText.text
        pet?.breed = breedText.text
        pet?.looks = looksText.text
        pet?.color = colorText.text
        pet?.feature = featureTextView.text
        pet?.lastSeenTime = lastSeenTimeText.text
        pet?.lastSeenAddr = lastSeenAddrText.text
        pet?.name = nameText.text
        pet?.sex = sexText.text
        pet?.chip = chipText.text
        pet?.contactName = contactNameText.text
        pet?.contactNumber = contactNumberText.text


        completionCallBack!()
    }
    
    func selectImage() {
        // selecting Image from library
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        petImagesView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
