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
    
    // 覆寫 prepareForReuse()方法，避免 cell 滾出螢幕外被重複調用時，圖片亂掉
        override func prepareForReuse() {
            super.prepareForReuse()
            self.delegate = nil
        }
    

    @IBAction func LikeBtn(_ sender: UIButton) {
        
        self.delegate?.likeBtn(cell: self, numberOfLike: self.numberOfLike.text as! String)

    }
    
}


protocol Friend_sOwnTagListCellDelegate: class {
    func likeBtn(cell: Friend_sOwnTagListCell, numberOfLike: String)
}
