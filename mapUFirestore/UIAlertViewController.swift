//
//  UIAlertViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/8.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UIAlertViewController: UIViewController {

    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 兩顆按鈕警告視窗
    
    func twoBtnsAlert() {
        
        let controller = UIAlertController(title: "登入", message: "請輸入你在 B12 星球的電話和密碼", preferredStyle: .alert)
        controller.addTextField { (textField) in
           textField.placeholder = "電話"
           textField.keyboardType = UIKeyboardType.phonePad
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
           let phone = controller.textFields?[0].text
            
            if let uid = Auth.auth().currentUser?.uid {
                self.db.collection("userList").document(uid).updateData(["Phone": phone])
            
            }else {
                
                print("failed to update!")
            }
            
            
        }
        
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    
    func WhoYouVoteFor() {
        
        let controller = UIAlertController(title: "真心話大冒險", message: "請問誰是你的最愛?", preferredStyle: .actionSheet)
        let names = ["小龍女", "中龍女", "大龍女"]
        for name in names {
           let action = UIAlertAction(title: name, style: .default) { (action) in
              print(action.title)
           }
           controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func testAlertAction(_ sender: UIButton) {
        
        twoBtnsAlert()
            }
    
    @IBAction func WhoYouVoteFor(_ sender: UIButton) {
        WhoYouVoteFor()
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
