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
    
    
    
    var tagsForVote: [String] = []
    var userNameArr: [String] = []
    var tagArr = [Tag]()
    var TagInstanceForVote: Tag?
    var shuffledTagArr = [Tag]()
    var followingList = [User]()
    
//    let db = Firestore.firestore()
//    var userListRef: DocumentReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //匿名登入
        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                API.UserRef.userRef.child("\(authresult!.user.uid)").setValue(["name": "test"])
            print("signed-in \(authresult!.user.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
        fetchTagPool(completionHandler: { tagArr in
            self.shuffledTagArr = tagArr!.shuffled()
            self.TagInstanceForVote = self.outputRandomTagInstance(tagArr: self.shuffledTagArr)
          
            self.randomTag.text = self.TagInstanceForVote?.tagContent
        })
        
        
    }
    
    typealias TagArrayClosure = ([Tag]?) -> Void

    //撈出tagPool底下所有資料匯入class並作為日後存取相關資料所用
    func fetchTagPool(completionHandler: @escaping TagArrayClosure) {
        var result = [Tag]()
        
            API.Tag.observeTagPool { tag in
                result.append(tag)
               
                DispatchQueue.main.async() {
                    if result.isEmpty {
                        completionHandler(nil)
                    }else {
                        completionHandler(result)
                      }
        }
    }
    }
    
    func outputRandomTagInstance(tagArr: [Tag]) -> Tag {
        
        return tagArr[2]

//            shuffledArr = self.tagArr.shuffled()

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
