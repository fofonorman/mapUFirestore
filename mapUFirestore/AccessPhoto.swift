//
//  AccessPhoto.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/27.
//

import UIKit
import PhotosUI
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseAuth


class AccessPhoto: UIViewController, UINavigationControllerDelegate {

    let imagePickerController = UIImagePickerController()
    let storageRef = Storage.storage().reference()

    @IBOutlet weak var testImageFromURL: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        Auth.auth().signInAnonymously(completion: { _,_  in
//
//            print(Auth.auth().currentUser?.uid)
//        })／
        
//     測試從圖片URL轉成顯示於前端的圖片
       let photoURLString = "https://firebasestorage.googleapis.com/v0/b/mapufirestore.appspot.com/o/G53HUXuPtBPvgdm2KxlR7dCE0SD3%2FProfileImage.jpg?alt=media&token=21e191c7-29f1-42da-aa09-ef2e2c2015f5"
        
        let photoURL = URL(string: photoURLString)
        self.testImageFromURL.sd_setImage(with: photoURL, completed: nil)
        
                    print(Auth.auth().currentUser?.uid)

        imagePickerController.delegate = self
    }
    
    
    
    @IBAction func DennyTeacherUploadPic(_ sender: UIButton) {
//        實例化一個選擇asset的class
        let imagePicker = UIImagePickerController()
//        asset來源設定為裝置內所貯存的asset
        imagePicker.sourceType = .photoLibrary
//        設定為不可編輯此asset
        imagePicker.allowsEditing = false
//        顯示圖素之處設定為self，這個寫法還待確認其意義
        imagePicker.delegate = self
//        跳出選擇asset的彈窗
        present(imagePicker, animated: true, completion: nil)
    }
    
  

    @IBAction func selectPhoto(_ sender: UIButton) {
        theSrouceToAccessPhoto()

        
    }
    

    @IBAction func photoImage(_ sender: UITapGestureRecognizer) {
        
      theSrouceToAccessPhoto()
        
                
    }
    
    
    func theSrouceToAccessPhoto() {
        
        let controller = UIAlertController(title: "修改頭圖", message: "", preferredStyle: .alert)
            controller.view.tintColor = UIColor.gray

            // 相機
            let cameraAction = UIAlertAction(title: "相機", style: .default) { _ in
                self.takePicture()
            }
            controller.addAction(cameraAction)

            // 圖庫
            let photoLibraryAction = UIAlertAction(title: "照片", style: .default) { _ in
                self.openPhotoLibrary()
            }
            controller.addAction(photoLibraryAction)

            // 相薄
            let savedPhotosAlbumAction = UIAlertAction(title: "相簿", style: .default) { _ in
                self.openPhotosAlbum()
            }
            controller.addAction(savedPhotosAlbumAction)

            let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
            controller.addAction(cancelAction)

            self.present(controller, animated: true, completion: nil)
        
    }
    
    
    /// 開啟相機
    func takePicture() {
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true)
    }

    /// 開啟圖庫
    func openPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }

    /// 開啟相簿
    func openPhotosAlbum() {
        imagePickerController.sourceType = .savedPhotosAlbum
        self.present(imagePickerController, animated: true)
    }
  
    @IBAction func uploadImage(_ sender: UIButton) {
        // 建立一個 UIImagePickerController 的實體
              let imagePickerController = UIImagePickerController()

              // 委任代理
              imagePickerController.delegate = self

              // 建立一個 UIAlertController 的實體
              // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
              let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)

              // 建立三個 UIAlertAction 的實體
              // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
              let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in

                  // 判斷是否可以從照片圖庫取得照片來源
                  if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

                      // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                      imagePickerController.sourceType = .photoLibrary
                      self.present(imagePickerController, animated: true, completion: nil)
                  }
              }
              let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in

                  // 判斷是否可以從相機取得照片來源
                  if UIImagePickerController.isSourceTypeAvailable(.camera) {

                      // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                      imagePickerController.sourceType = .camera
                      self.present(imagePickerController, animated: true, completion: nil)
                  }
              }

              // 新增一個取消動作，讓使用者可以跳出 UIAlertController
              let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in

                  imagePickerAlertController.dismiss(animated: true, completion: nil)
              }

              // 將上面三個 UIAlertAction 動作加入 UIAlertController
              imagePickerAlertController.addAction(imageFromLibAction)
              imagePickerAlertController.addAction(imageFromCameraAction)
              imagePickerAlertController.addAction(cancelAction)

              // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
              present(imagePickerAlertController, animated: true, completion: nil)
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

//    執行動作：挑選照片，上傳資料庫，顯示到前端
extension AccessPhoto: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info 用來取得不同類型的圖片，此 Demo 的型態為 originaImage，其它型態有影片、修改過的圖片等等，這段就是執行“點擊圖片之後，顯示在頁面上”的 method
        if let currentUserUID = Auth.auth().currentUser?.uid {
        
            let previousAvatarRefToDelete = self.storageRef.child(currentUserUID).child("ProfileImage.jpg")
            
            previousAvatarRefToDelete.delete { error in

                if let existingError = error {
                    print("\(String(describing: error))")
                }else{
                    print("deleted succesfully!")
                }
                }
            
        if let image = info[.originalImage] as? UIImage {
            
            let fileReference = Storage.storage().reference().child(currentUserUID).child("ProfileImage" + ".jpg")
//            UUID().uuidString, 產生UID連結的method
                
            if let imageData = image.jpegData(compressionQuality: 0.9) {
                     fileReference.putData(imageData, metadata: nil) { (_, error) in
                         guard error == nil else {
                             print("upload error")
                             return
                         }
                                               
                        fileReference.downloadURL (completion: { (url, error) in
                            guard let downloadURL = url else {
                               print("no URL")
                               return
                            }
                            
                     
                            API.UserRef.db.collection("userList").document(currentUserUID).setData(["ProfileImage": "\(downloadURL)"], merge: true)
                            print("this is \(downloadURL)")
                             
                        })
                     }
                 }
            self.photoImageView.image = image

            }
            
        picker.dismiss(animated: true)
        }
    }
     
    }

