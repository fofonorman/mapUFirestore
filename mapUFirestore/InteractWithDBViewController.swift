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
    
    static let shared = InteractWithDBViewController()
    @IBOutlet weak var randomTag: UILabel!
    @IBOutlet weak var inputTag: UITextField!
    
    @IBOutlet weak var FriendBtnA: UIButton!
    @IBOutlet weak var FriendBtnB: UIButton!
    
    var userNameArr: [String] = []
    var TagInstanceForVote: Tag?
    var FollowingListInstance: User?
    var FollowingList = [User]()
    var tagsForVoteList = [Tag]()

    let db = Firestore.firestore()
//    var followingListArrRandomIndex = 0

//    let db = Firestore.firestore()
//    var userListRef: DocumentReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userData: [String: Any] = [
        
            "name": "fakeUser",
            "school": "fakeSchool"
        
        ]
        
        //匿名登入
        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                API.UserRef.db.collection("userList").document(                authresult!.user.uid).setData(userData, merge: true)
                
                self.fetchFollowingList(completionHandler: { userArr in

                 self.FollowingList = userArr!

                 self.assignNewFollowingInstanceToFrontEnd()


                 }
                )
                
            print("signed-in \(Auth.auth().currentUser!.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
        fetchTagPool(completion: { tags in

            self.tagsForVoteList = tags!

            self.assignNewTagInstanceToFrontEnd()

        })

      
           
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "GoToFollowingListToVote"{
            
            if let followingListToVote = segue.destination as? FollowingListToVote {
                followingListToVote.infoFromPreviousPage = sender as? [User]
            }
        }
    }
  
        @IBAction func GoToFollowingListToVote(_ sender: UIButton) {
    performSegue(withIdentifier: "GoToFollowingListToVote", sender: self.FollowingList)

    }
    
    
    typealias TagArrayClosure = ([Tag]?) -> Void

    //撈出tagPool底下所有資料匯入class並作為日後存取相關資料所用
    func fetchTagPool(completion: @escaping TagArrayClosure) {
        var result = [Tag]()

            API.Tag.observeTagPool { tag in
                result.append(tag)

                DispatchQueue.main.async() {
                    if result.isEmpty {
                        completion(nil)
                    }else {
                        completion(result)
                      }
        }
    }
    }
    
    typealias FollowingListArrayClosure = ([User]?) -> Void

    //撈出followingList底下所有資料匯入class並作為日後存取相關資料所用
    func fetchFollowingList(completionHandler: @escaping FollowingListArrayClosure) {
        var result = [User]()

             
        API.FollowingList.fetchFollowingList(withID: Auth.auth().currentUser!.uid) { users in
                result.append(users)

                DispatchQueue.main.async() {
                    if result.isEmpty {
                        completionHandler(nil)
                    }else {
                        completionHandler(result)

                      }
        }
    }
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
                print(document.data())
              }
           }
        }
                
    }
    
    
    func test(withID uid: String) {
        
        db.collection("tagPoolDefault").document(uid).updateData(["whoGotThisTag": FieldValue.arrayUnion(["USERDDDDDD"])])
    }
  
    @IBAction func FriendABtn(_ sender: UIButton) {

     
        
//      按下投票鈕時，透過 actionsAfterClickFriendToVote() 將資料存入資料庫
        actionsAfterClickFriendToVote(withUID: self.FollowingListInstance?.uid as! String, withTagContent: self.TagInstanceForVote?.tagContent as! String, withTagID: self.TagInstanceForVote?.tagID as! String)
        
    }
    
    
    @IBAction func FriendBBtn(_ sender: UIButton) {
        
        actionsAfterClickFriendToVote(withUID: self.FollowingListInstance?.uid as! String, withTagContent: self.TagInstanceForVote?.tagContent as! String, withTagID: self.TagInstanceForVote?.tagID as! String)
        
    }
    
    
    
    func assignNewTagInstanceToFrontEnd() {
                  
        self.TagInstanceForVote = self.tagsForVoteList.randomElement()
        self.randomTag.text = self.TagInstanceForVote?.tagContent
        
    }
    
    func assignNewFollowingInstanceToFrontEnd() {
    
       self.FollowingListInstance = self.FollowingList.randomElement()
       self.FriendBtnA.setTitle(self.FollowingListInstance?.displayName, for: .normal)
    
       self.FollowingListInstance = self.FollowingList.randomElement()
       self.FriendBtnB.setTitle(self.FollowingListInstance?.displayName, for: .normal)
        
        
    }
    
    
    func actionsAfterClickFriendToVote (withUID uid: String, withTagContent tagContent: String, withTagID tagID: String) {
//        如果對象已經被投過此標籤了，要設計預期效果，尚未完成
       
        db.collection("userList").document(uid).collection("TagIGot").getDocuments { (querySnapshot, error) in
            
            guard let _ = querySnapshot else { print("no result!")
                return}
            
        }
        
        let tagListData: [String: Any] = [
        
            "tagContent": TagInstanceForVote?.tagContent,
            "thumbUp": [String](),
            "likedByYou": false,
            "ifRead": false

        ]
        
        db.collection("userList").document(uid).collection("TagIGot").document((TagInstanceForVote?.tagID!)!).setData(tagListData, merge: true)
        
        db.collection("tagPoolDefault").document(tagID).updateData(["whoGotThisTag": FieldValue.arrayUnion([uid])])
        
        assignNewTagInstanceToFrontEnd()
        assignNewFollowingInstanceToFrontEnd()
        
    }
    
    
    @IBAction func testBtn(_ sender: UIButton) {
        test(withID: "VvJTZHoJ3B4PUcMGJ8E0")
        
//        API.FollowingList.fetchFollowingList(withID: Auth.auth().currentUser!.uid) {
//
//            ( friend ) in
//
//            self.shuffledFollowingList.append(friend)
//
//           self.FriendBtnA.setTitle(self.shuffledFollowingList[0].displayName, for: .normal)
//
//        }
        
//
//        db.collection("userList").document(Auth.auth().currentUser!.uid).collection("TagIGot").document(TagInstanceForVote?.tagID as! String).setData([TagInstanceForVote?.tagContent as! String: true])
//
////        將收到標籤的用戶放到標籤文件底下的whoGotThisTag
//        db.collection("tagPoolDefault").document(TagInstanceForVote?.tagID as! String).updateData(<#T##fields: [AnyHashable : Any]##[AnyHashable : Any]#>)
        
        
//        .addDocument(data: [TagInstanceForVote?.tagContent as! String: true])
//
        
        
//        document("TagIGot").updateData([TagInstanceForVote?.tagContent: true])
        
        
        
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
