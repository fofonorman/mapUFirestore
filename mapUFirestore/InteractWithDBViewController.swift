//
//  InteractWithDBViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/6.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class InteractWithDBViewController: UIViewController {
    
    
    @IBOutlet weak var randomTag: UILabel!
    @IBOutlet weak var inputTag: UITextField!
    
    
    var tagsForVote: [String] = []
    var userNameArr: [String] = []
    var tagArr = [Tag]()
    var TagInstanceForVote: Tag?
    var shuffledTagArr = [Tag]()
    var followingList = [User]()
    let db = Firestore.firestore()

//    let db = Firestore.firestore()
//    var userListRef: DocumentReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //匿名登入
        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                self.db.collection("userList").document("\(authresult!.user.uid)").updateData(["ABABa": "CCCC"])
                
            print("signed-in \(authresult!.user.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
//        fetchTagPool(completionHandler: { tagArr in
//            self.shuffledTagArr = tagArr!.shuffled()
//            self.TagInstanceForVote = self.outputRandomTagInstance(tagArr: self.shuffledTagArr)
//          
//            self.randomTag.text = self.TagInstanceForVote?.tagContent
//        })
        
        fetchTag()
    }
    
    typealias TagArrayClosure = ([Tag]?) -> Void

    //撈出tagPool底下所有資料匯入class並作為日後存取相關資料所用
//    func fetchTagPool(completionHandler: @escaping TagArrayClosure) {
//        var result = [Tag]()
//
//            API.Tag.observeTagPool { tag in
//                result.append(tag)
//
//                DispatchQueue.main.async() {
//                    if result.isEmpty {
//                        completionHandler(nil)
//                    }else {
//                        completionHandler(result)
//                      }
//        }
//    }
//    }
    
    func outputRandomTagInstance(tagArr: [Tag]) -> Tag {
        
        return tagArr[2]

//            shuffledArr = self.tagArr.shuffled()

        }
    
    
    @IBAction func tagSubmitBtn(_ sender: UIButton) {
        
        let data = ["tagContent": self.inputTag.text]
        
        if self.inputTag.text?.isEmpty == true {
            
            let controller = UIAlertController(title: "Failed", message: "Please input a tag.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(ACTION: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
                
            })
                
            controller.addAction(okAction)
              
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(ACTION: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
                
            })
                
            controller.addAction(cancelAction)
//            let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
//            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
            
        }else{
            
            db.collection("tagPoolDefault").addDocument(data: data)
         
            self.inputTag.text = ""
        }
    }
    
//   測試撈 tag 資料
    
    func fetchTag() {
        
        db.collection("tagPoolDefault").getDocuments { (querySnapshot, error) in
           if let querySnapshot = querySnapshot {
              for document in querySnapshot.documents {
                 print(document.documentID)
              }
           }
        }
                
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
