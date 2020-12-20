//
//  Friend'sOwnTagListCell.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit
import FirebaseFirestoreSwift

class Friend_sOwnTagListCell: UITableViewCell {
    
    @IBOutlet weak var LikeImage: UIButton!
    @IBOutlet weak var tagContent: UILabel!
    @IBOutlet weak var numberOfLike: UILabel!
    
    var delegate: Friend_sOwnTagListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
     //                  成功撈出tumbUp了，接下來處理怎麼
     //        queryThumbUp(withUID: "GOhc9KTUoSXRtPx3TKt9")
        
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 覆寫 prepareForReuse()方法
        override func prepareForReuse() {
            super.prepareForReuse()
            self.delegate = nil
        }
    
//    按下按鈕後要將讚數寫入或從資料庫中撤回＞畫面要做相對應的讚數數字更新

    @IBAction func LikeBtn(_ sender: UIButton) {
        
//        if self.LikeImage.currentImage == UIImage(named : "afterLike") {
//
//            self.LikeImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal)
//
//        }else {
//            self.LikeImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.normal)

//        }
        
        self.delegate?.likeBtn(cell: self, numberOfLike: self.numberOfLike.text as! String)
        
    }
    
////  撈每個tag裡的thumbUp陣列
//    func queryThumbUp(withUID UID: String) {
//
//        API.UserRef.db.collection("userList").document(UID).collection("TagIGot").addSnapshotListener({ (querySnapshot, error) in
//
//            guard let existingSnapShot = querySnapshot else {
//
//                print("no result! \(error!)")
//                return }
//
//            existingSnapShot.documentChanges.forEach({ (documentChange) in
//
//                if documentChange.type == .added {
//
//                let thumb = documentChange.document.data()["thumbUp"] as? [String]
//                    print(thumb)
//                }else{
//                print("no value in thumbUp Array")
//
//                }
//
//            })
//
//        })
//
//    }
    

}


protocol Friend_sOwnTagListCellDelegate: class {
    func likeBtn(cell: Friend_sOwnTagListCell, numberOfLike: String)
}
