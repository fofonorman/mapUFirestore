//
//  PhotoCollectionView.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/7.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class PhotoCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {

        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 25
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
        // Configure the cell
        cell.photoImage.image = UIImage(named: "002")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    

    

    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension PhotoCollectionView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
                var selectedImageFromPicker: UIImage?
    
                // 取得從 UIImagePickerController 選擇的檔案
                if let pickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
    
                    selectedImageFromPicker = pickedImage
                }
    
                // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
                let uniqueString = NSUUID().uuidString
    
                // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
                if let selectedImage = selectedImageFromPicker {
    
                    let storageRef = Storage.storage().reference().child("AppCodaFireUpload").child("\(uniqueString).png")
    
                    if let uploadData = selectedImage.pngData() {
                            // 這行就是 FirebaseStorage 關鍵的存取方法。
    
                        storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
    
                                if error != nil {
    
                                    // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                                    print("Error: \(error!.localizedDescription)")
                                    return
                                }
    
                                // 連結取得方式
                             storageRef.downloadURL{ (url, error) in
    
                                guard let downloadURL = url else {
                                    print("Failed to get URL!")
                                    return
                                }
                       // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
                                print("Photo Url: \(downloadURL)")
    
    
                            }
    
                            })
                        }            }
    
                dismiss(animated: true, completion: nil)
            }
    
    
    
        }

