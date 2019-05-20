//
//  MedicalViewController.swift
//  Endoscope
//
//  Created by Adam Smith on 2019. 05. 19..
//  Copyright © 2019. Kovács Ádám. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class MedicalViewController: MenuViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //UI elemek
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var error: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
        A probléma felvitele az adatbázisba.
        Kép feltöltése a storage -ba
        Egyébb adatok felvitele a firestore -ba
    */
    @IBAction func sendToDoctor(_ sender: UIButton) {
        //Kép feltöltése
        uploadImage(image.image!)
        
        if(message.text!.count == 0){
            error.isHidden = false
        }else {
            //Adatok felvitele
            let db = Firestore.firestore()
            let usersRef = db.collection("problems")
            let userID = Auth.auth().currentUser!.uid
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            let currentDate = dateFormatter.string(from: NSDate() as Date)
            
            let messageString = message.text!
            
            usersRef.document(userID).setData([
                "userID": userID,
                "name": Database.patient.name,
                "message": messageString,
                "time": currentDate
                ])
            self.navigationController?.popToRootViewController(animated: true)
            error.isHidden = true
        }
    }
    
    //Meghívjuk, a gombra a camerát
    @IBAction func takePhoto(_ sender: UIButton) {
        //Ha elérhető a kamera
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //Ugorjon fel a képernyő amikor a textField be írunk
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(self.navigationItem.title! == "Medical examination"){
            if(textField.placeholder == "Your problems & observations"){
                //333.5
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.center.y = 133.5
                })
            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.center.y = 333.5
                })
            }
        }
    }
    
    //Betöltjük a kép helyére az ujonnan camerával csinált képet
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //Kép feltöltése
    func uploadImage(_ takedImage: UIImage){
        let userID = Auth.auth().currentUser!.uid
        var data = Data()
        data = takedImage.jpegData(compressionQuality: 0.75)!
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("users/\(userID)/takedImage.jpeg")
        
        
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
    }
}
