//
//  Friend'sOwnTagListCell.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit

class Friend_sOwnTagListCell: UITableViewCell {

    
    @IBOutlet weak var LikeImage: UIButton!
    @IBOutlet weak var tagContent: UILabel!
    @IBOutlet weak var numberOfLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.LikeImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal) // 預設狀態下要顯示的圖片
                self.LikeImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.selected) // 選取狀態下要顯示的圖片
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    按下按鈕後要將讚數寫入資料庫
    @IBAction func LikeBtn(_ sender: UIButton) {
        
        if !self.LikeImage.isSelected {
            
            API.UserRef.db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9")
            
        }
        
        
        self.LikeImage.isSelected = !sender.isSelected

        
    }
    
    
    

}
