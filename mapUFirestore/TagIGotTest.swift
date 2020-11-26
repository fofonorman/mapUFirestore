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
        
        var tagIGotList = [QueryDocumentSnapshot]()

        db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").addSnapshotListener { (querySnapshot, error) in
           guard let querySnapshot = querySnapshot else {
              return
           }
           querySnapshot.documentChanges.forEach({ (documentChange) in
              if documentChange.type == .added {
             
                             
              let tagID = documentChange.document.documentID
              
              
             
                
                
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
