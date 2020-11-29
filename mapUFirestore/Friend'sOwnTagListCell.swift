//
//  Friend'sOwnTagListCell.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit

class Friend_sOwnTagListCell: UITableViewCell {

    
    @IBOutlet weak var tagContent: UILabel!
    @IBOutlet weak var numberOfLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
