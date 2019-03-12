//
//  ViewController.swift
//  todoAppFB
//
//  Created by abdul ahad on 09/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var iName: UITextField!
    @IBOutlet weak var iCost: UITextField!
    @IBOutlet weak var iLocation: UITextField!
    @IBOutlet weak var iDescription: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
     var ref = DatabaseReference.init()
     let ImagePicker = UIImagePickerController()
     var arrdata = [Chatmodel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        ImagePicker.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
       let tapGesture = UITapGestureRecognizer()

        tapGesture.addTarget(self, action: #selector(ViewController.openGallery(tapGesture:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGesture)

    }

    func saveFIRData() {
        self.uploadMedia(self.imgView.image!){ url in
            
            self.saveImg(name: self.iName.text!,cost: self.iCost.text!,location: self.iLocation.text!,description: self.iDescription.text!,profileURL: url!){ success in
                if success != nil {
                    print("ok")
                }
            }
        }
    }
    
    
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        self.setupImagePick()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        self.saveFIRData()

    }
    
    
}
extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    func setupImagePick() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            ImagePicker.sourceType = .savedPhotosAlbum
            ImagePicker.delegate = self
            ImagePicker.isEditing = true
            self.present(ImagePicker, animated: true, completion: nil)
        }
    
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imge = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgView.image = imge
        self.dismiss(animated: true, completion: nil )
    }
    
    func uploadMedia(_ image:UIImage, completion: @escaping ((_ url: URL?) -> ())){
            let storageRef = Storage.storage().reference().child("images").child("image.png")
            if let imgData = image.pngData() {
                let metaData = StorageMetadata()
                metaData.contentType = "image/png"
                storageRef.putData(imgData, metadata: metaData) { (metaData, error) in
                    if error == nil {
                        print("success")
                        storageRef.downloadURL(completion: { (url, error) in
                            completion(url)
                        })
                    }else {
                        print("error")
                        completion(nil)
                    }
                }
            }
        }
        func saveImg(name: String,cost: String,location: String,description: String,profileURL: URL,completion: @escaping ((_ url: URL?) -> ())){
            
            let dict = ["name":iName.text!, "cost":iCost.text!,"location":iLocation.text!,"description":iDescription.text!, "profileURL":profileURL.absoluteString] as! [String: Any]
            self.ref.child("toDo").childByAutoId().setValue(dict)
        }
    
}

