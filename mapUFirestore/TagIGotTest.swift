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
        
        fetchTagTheUserGotList() { (result) in
            print(result)
        
             }
        
        self.thumbUpImage.isSelected = !sender.isSelected
        
    }
    
    
   
    
    func fetchTagTheUserGotList(completion: @escaping (TagTheUserGot) -> Void) {
        
        var likedArr = [String]()
//  研究怎麼將thumbup陣列取出，與相對應的文件貯存起來

        db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                return
            }

            for document in snapshot.documents {
                
                 let tagContent = document.data()["tagContent"] as! String
                    
                    let tagID = document.documentID
                    let likedByYou = false
                    let numberOfLiked = 6
                        
                
                 let thumb = document.data()["thumbUp"]
                    
                
                
                if let thumbs = thumb {
                    
                    likedArr.append(thumbs as! String)
                    
                    print(likedArr)
                    
                }

                
                
//                let numberOfLiked = LikedArr.count
                
                
                    let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent, thumbUpByYou: likedByYou)
                    
                    completion(tagListMember)
                    
                
               
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


