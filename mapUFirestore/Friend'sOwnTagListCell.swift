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
    

    @IBAction func LikeBtn(_ sender: UIButton) {
        
//        if self.LikeImage.currentImage == UIImage(named : "afterLike") {
//
//            self.LikeImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal)
//
//        }else {
//            self.LikeImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.normal)
//
//        }
        
        self.delegate?.likeBtn(cell: self, numberOfLike: self.numberOfLike.text as! String)
        
    }
    
}


protocol Friend_sOwnTagListCellDelegate: class {
    func likeBtn(cell: Friend_sOwnTagListCell, numberOfLike: String)
}
