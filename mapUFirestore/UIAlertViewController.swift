//
//  UIAlertViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/8.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UIAlertViewController: UIViewController, UITextFieldDelegate {

    let db = Firestore.firestore()
    var friNameForVote = [String]()
    var tagContent = [String]()
    var shuffledTagContent = [String]()
    
    @IBOutlet weak var shareText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareText.delegate = self

        
       
         
     }

        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
      }
    
    //晃動效果
  
//
//        func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
//               let animation = CABasicAnimation(keyPath: "position")
//               animation.duration = timeDuration
//               animation.repeatCount = countRepeat
//               animation.autoreverses = true
//            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.view.center.x - 10, y: self.view.center.y))
//            animation.toValue = NSValue(cgPoint: CGPoint(x: self.view.center.x + 10, y: self.view.center.y))
//            self.view.layer.add(animation, forKey: "position")
//           }

        

    
 
    
    // 兩顆按鈕輸入欄位視窗
    
    func twoBtnsAlert() {
        
        let controller = UIAlertController(title: "驗證", message: "請輸入驗證碼", preferredStyle: .alert)
        controller.addTextField { (textField) in
           textField.placeholder = "驗證碼"
           textField.keyboardType = UIKeyboardType.phonePad
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
           let verifyCode = controller.textFields?[0].text
            
            if let uid = Auth.auth().currentUser?.uid {
                
                if verifyCode != "" {
                    
                    self.db.collection("userList").document(uid).updateData(["verifyCode": verifyCode])
                
                }else {
                    let animation = CABasicAnimation(keyPath: "position")
                    animation.duration = 0.07
                    animation.repeatCount = 4
                    animation.autoreverses = true
                    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.view.center.x - 10, y: self.view.center.y))
                    animation.toValue = NSValue(cgPoint: CGPoint(x: self.view.center.x + 10, y: self.view.center.y))

                    self.view.layer.add(animation, forKey: "position")
                }
            
            
            }}
        
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    
    
    
    
   
    
    
//    分享貼文到其他 app
    func sharePost() {
        let activityController = UIActivityViewController(activityItems: [shareText.text!, UIImage(named: "testPic")], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func testAlertAction(_ sender: UIButton) {
      twoBtnsAlert()
          
    }
    
    @IBAction func WhoYouVoteFor(_ sender: UIButton) {
       sharePost()
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
