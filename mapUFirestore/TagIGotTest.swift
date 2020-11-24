//
//  TagIGotTest.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/24.
//

import UIKit

class TagIGotTest: ViewController {

    @IBOutlet weak var thumbUpImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.thumbUpImage.setImage(UIImage(named : "kkkgi"), for: UIControl.State.normal) // 預設狀態下要顯示的圖片
                self.thumbUpImage.setImage(UIImage(named : "testPic"), for: UIControl.State.selected) // 選取狀態下要顯示的圖片
        
        
        
    }
    

    @IBAction func thumbUp(_ sender: UIButton) {
        
        self.thumbUpImage.isSelected = !sender.isSelected
        
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
