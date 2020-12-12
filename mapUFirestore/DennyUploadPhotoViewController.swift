//
//  DennyUploadPhotoViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/11.
//

import UIKit
import Firebase


class DennyUploadPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let storageRef = Storage.storage().reference()

    @IBOutlet weak var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Auth.auth().signInAnonymously(completion: nil)
        print(Auth.auth().currentUser?.uid)
        
//        uploadSampleFromPeterPan()
        displayImage()
        
    }
    
    func displayImage() {
        
//       成功用getdata方式來取得圖素網址下載並顯示於前端
        
        if let userUID = Auth.auth().currentUser?.uid {
           
            let db = Firestore.firestore()
            db.collection("userList").document(userUID).getDocument { (document, error) in
               if let document = document, document.exists {
                
                var theUIImage: UIImage? = nil
                
                if let linkString = document.data()!["ProfileImage"] as? String {
                    
                    if let imageURL = URL.init(string: linkString){
                        
                        do{ let data = try Data.init(contentsOf: imageURL)
                            theUIImage = UIImage(data: data)
                            
                        }catch{
                            
                        }
                    }
                    
                }
                        self.avatar.image = theUIImage

                print(document.data()!["ProfileImage"]!)
               } else {
                  print("Document does not exist")
               }
            }
            
        }
  
        
        
        
        
       
        
    }
    
    
    @IBAction func uploadPic(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let storageRef = Storage.storage().reference().child("pic")
        
         let image = info[UIImagePickerController.InfoKey.imageURL] as? UIImage
        
        var fileName = "image.JPG"
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            
            fileName = url.lastPathComponent
                       
        }
        
        if let theUid = Auth.auth().currentUser?.uid {
            
            if let data = image?.jpegData(compressionQuality: 0.5){
                storageRef.child(theUid).child(fileName).putData(data)
            }
            }
        picker.dismiss(animated: true, completion: nil)
    }
        
//    可成功上傳照片
    func uploadSampleFromPeterPan() {
//        上傳到資料庫中的檔名
        let fileReference = self.storageRef.child("009.jpeg")

//        取得asset裡的圖片方法
        let image = UIImage(named: "001")
        if let imageData = image?.jpegData(compressionQuality: 0.9) {
            
//            上傳圖片的method
            fileReference.putData(imageData, metadata: nil) { (metadata, error) in
               guard let _ = metadata, error == nil else {
                  print("no metadata")
                  return
               }
               fileReference.downloadURL(completion: { (url, error) in
                  guard let downloadURL = url else {
                     print("no URL")
                     return
                  }
                  print("this is \(downloadURL)")
               })
            }
            
        }

    }
    
//    彼得潘的範例：上傳檔案後將檔案存在database
    func uploadPhoto(completion: @escaping (URL?) -> () ) {
            
//        使用函式自動產生uid連結
            let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
            
        let image = UIImage(named: "001")

           if let imageData = image?.jpegData(compressionQuality: 0.9) {
                fileReference.putData(imageData, metadata: nil) { (_, error) in
                    guard error == nil else {
                        print("upload error")
                        return
                    }
                    fileReference.downloadURL { (url, error) in
                        completion(url)
                    }
                }
            }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
