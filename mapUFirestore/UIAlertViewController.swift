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

        
        getUserListID(completionHandler: {  friName in
            print(self.friNameForVote)

        })
        
        getTagContent(completionHandler: {  tag in
         
            self.shuffledTagContent = self.tagContent.shuffled()
            print(self.shuffledTagContent)
         
     })

        
        
        
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
                
                if phone != "" {
                    
                    self.db.collection("userList").document(uid).updateData(["Phone": phone])
                
                }else {
//                    let animation = CABasicAnimation(keyPath: "position")
//                    animation.duration = 0.07
//                    animation.repeatCount = 4
//                    animation.autoreverses = true
//                    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: controller.center.y))
//                    animation.toValue = NSValue(cgPoint: CGPoint(x: controller.center.x + 10, y: viewToShake.center.y))
//
//                    controller.layer.add(animation, forKey: "position")
                }
            
            
            }}
        
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    
    func WhoYouVoteFor() {
        
     
        let controller = UIAlertController(title: "真心話大冒險", message: "Try it!!" , preferredStyle: .actionSheet)
        let names = self.friNameForVote
        for name in names {
           let action = UIAlertAction(title: name, style: .default) {
            (action) in
            print(action.title)
            
            if Auth.auth().currentUser?.uid != nil {
                           self.db.collection("tagPoolDefault").document("HBOxvMyqeNmOSsTm4aDi").updateData(["test": "AAAAA"])
            }
            else{
                 return
            }
        }

           controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
        
        }
    
    
    typealias TagArrayClosure = ([String]?) -> Void

    func getUserListID (completionHandler: @escaping TagArrayClosure  ) {
        
        db.collection("userList").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    
                    if var friName = document.data()["name"] as? String {
                        self.friNameForVote.append(friName)
                        
                        DispatchQueue.main.async() {
                            if self.friNameForVote.isEmpty {
                                completionHandler(nil)
                            }else {
                                completionHandler(self.friNameForVote)
                              }
                             }
                        
                    } else {
                        print(error)
                    }
                    
              }
           }
        }
        
    }
    
    func getTagContent (completionHandler: @escaping TagArrayClosure  ) {
        
        db.collection("tagPoolDefault").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    
                    if var tags = document.data()["tagContent"] as? String {
                        self.tagContent.append(tags)
                        
                        DispatchQueue.main.async() {
                            if self.tagContent.isEmpty {
                                completionHandler(nil)
                            }else {
                                completionHandler(self.tagContent)
                              }
                             }
                        
                    } else {
                        print(error)
                    }
                    
              }
           }
        }
        
    }
    
    func twoBtnToDiscardChange() {
        
        let alert = UIAlertController(title: "Alert", message: "Alert with more than 2 buttons", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { (_) in
                    print("You've pressed default")
                }))

                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                    print("You've pressed cancel")
                }))

//                alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { (_) in
//                    print("You've pressed the destructive")
//                }))
                self.present(alert, animated: true, completion: nil)

        
    }
    
//    分享貼文到其他 app
    func sharePost() {
        let activityController = UIActivityViewController(activityItems: [shareText.text!, UIImage(named: "testPic")], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func testAlertAction(_ sender: UIButton) {
        sharePost()
          
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
