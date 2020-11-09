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
    var friNameForVote = [String]()
    var tagContent = [String]()
    var shuffledTagContent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserListID(completionHandler: {  friName in
            print(self.friNameForVote)

        })
        
        getTagContent(completionHandler: {  tag in
         
            self.shuffledTagContent = self.tagContent.shuffled()
            print(self.shuffledTagContent)
         
     })

        
        
        
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
        
     
        let controller = UIAlertController(title: "真心話大冒險", message: self.shuffledTagContent[0] , preferredStyle: .actionSheet)
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
    
    @IBAction func testAlertAction(_ sender: UIButton) {
        
          
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
