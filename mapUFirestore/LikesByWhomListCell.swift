//
//  LikesByWhomListCellTableViewCell.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/14.
//

import UIKit

class LikesByWhomListCell: UITableViewCell {

    @IBOutlet weak var UserAvtar: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
