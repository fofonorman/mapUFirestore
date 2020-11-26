//
//  TagIGotTest.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/24.
//

import UIKit
import FirebaseFirestore

class TagIGotTest: ViewController {

    @IBOutlet weak var thumbUpImage: UIButton!
    @IBOutlet weak var tagContent: UILabel!
    @IBOutlet weak var numberOfThumbUp: UILabel!

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.thumbUpImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal) // 預設狀態下要顯示的圖片
                self.thumbUpImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.selected) // 選取狀態下要顯示的圖片
        
        
        
    }
    

    @IBAction func thumbUp(_ sender: UIButton) {
        
        fetchTagTheUserGotList()
        
        self.thumbUpImage.isSelected = !sender.isSelected
        
    }
    
    func fetchTagTheUserGotList() {
        
        var thumbUpsByUsers = [String]()

        db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").addSnapshotListener { (querySnapshot, error) in
           guard let querySnapshot = querySnapshot else {
              return
           }
           querySnapshot.documentChanges.forEach({ (documentChange) in
              if documentChange.type == .added {
             
                             
              let tagID = documentChange.document.documentID
              
                let tagContent = documentChange.document.data()["tagContent"]
                let likedByUsers = documentChange.document.data()["thumbUp"]
                
               
//怎麼撈出各自標籤下的某欄陣列值，再換算成各自標籤下的讚數？
                
              }
           })
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
