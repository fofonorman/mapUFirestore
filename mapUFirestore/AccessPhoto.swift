//
//  AccessPhoto.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/27.
//

import UIKit
import PhotosUI
import FirebaseFirestore

class AccessPhoto: UIViewController {

    let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imagePickerController.delegate = self
        
    }
    
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        theSrouceToAccessPhoto()

        
    }
    

    @IBAction func photoImage(_ sender: UITapGestureRecognizer) {
        
      theSrouceToAccessPhoto()
        
                
    }
    
    
    func theSrouceToAccessPhoto() {
        
        let controller = UIAlertController(title: "拍照?從照片選取?從相簿選取?", message: "", preferredStyle: .alert)
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
  
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AccessPhoto: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info 用來取得不同類型的圖片，此 Demo 的型態為 originaImage，其它型態有影片、修改過的圖片等等
        if let image = info[.originalImage] as? UIImage {
            self.photoImageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
}

extension AccessPhoto: UINavigationControllerDelegate { }


