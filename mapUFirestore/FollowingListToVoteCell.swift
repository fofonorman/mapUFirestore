//
//  FollowingListToVoteCell.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/8.
//

import UIKit

class FollowingListToVoteCell: UITableViewCell {

    @IBOutlet weak var UserAvatar: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    
    var delegate: FollowingListToVoteCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//     覆寫 prepareForReuse()方法，避免 cell 滾出螢幕外被重複調用時，圖片亂掉
    override func prepareForReuse() {
            super.prepareForReuse()
            self.delegate = nil
        }

    
    @IBAction func checkboxBtn(_ sender: UIButton) {
        self.delegate?.checkboxBtn(cell: self, userUID: self.UserNameLabel.text ?? "no result in cell")
    }
    
    
}

protocol FollowingListToVoteCellDelegate: class {
    
    func checkboxBtn(cell: FollowingListToVoteCell, userUID: String)
}
