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
   
//    struct Song: Equatable {
//       var name: String
//       var singer: String
//        static func == (lhs: Song, rhs: Song) -> Bool {
//              return lhs == rhs
//           }
//
//    }
    
//    var songs = [Song(name: "一次就好", singer: "楊宗緯"), Song(name: "兩次就好", singer: "楊宗緯"), Song(name: "三次就好", singer: "楊宗緯"), Song(name: "一次就好", singer: "彼得潘")]
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.thumbUpImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal) // 預設狀態下要顯示的圖片
                self.thumbUpImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.selected) // 選取狀態下要顯示的圖片
        
//        getIndex()
    }
    
//    func getIndex() {
//        let song1 = Song(name: "一次就好", singer: "彼得潘")
//            let song2 = Song(name: "一次就好", singer: "楊宗緯")
//
//            let index1 = self.songs.firstIndex(of: song1)
//        let index2 = self.songs.firstIndex(of: song2)
//
//
//        print(index1)
//        print(index2)
//
//
//    }
    

    
    
    
    @IBAction func thumbUp(_ sender: UIButton) {
        
//        fetchTagTheUserGotList() { (result) in
//
//            
//            self.tagContent.text = result.tagContent
//            self.numberOfThumbUp.text = String(result.numberOfThumbs!)
//
//            
//             }
        
        self.thumbUpImage.isSelected = !sender.isSelected
        
    }
    
    
   
    
//    func fetchTagTheUserGotList(completion: @escaping (TagTheUserGot) -> Void) {
//
//        db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").getDocuments { (snapshot, error) in
//
//            guard let snapshot = snapshot else {
//                return
//            }
//
//            for document in snapshot.documents {
//
//               let tagContent = document.data()["tagContent"] as! String
//
//               let thumb = document.data()["thumbUp"] as! [String]
//
//               let tagID = document.documentID
//               let likedByYou = false
//               let numberOfLiked = thumb.count
//
//               let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent, thumbUpByYou: likedByYou)
//
//                    completion(tagListMember)
//
//            }
//
//            }
//
//        }
        }
        
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


