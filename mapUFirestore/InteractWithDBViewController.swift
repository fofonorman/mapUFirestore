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
    
    @IBOutlet weak var FriendBtnA: UIButton!
    @IBOutlet weak var FriendBtnB: UIButton!
    
    var userNameArr: [String] = []
    var TagInstanceForVote: Tag?
    var FollowingListInstance: User?
    var FollowingList = [User]()
    var tagsForVoteList = [Tag]()

    let db = Firestore.firestore()
    var followingListArrRandomIndex = 0

//    let db = Firestore.firestore()
//    var userListRef: DocumentReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //匿名登入
        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                self.db.collection("userList").document(authresult!.user.uid).setData(["DDDD": "EEEEE"])
                
            print("signed-in \(authresult!.user.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
        fetchTagPool(completionHandler: { tags in
          
            self.tagsForVoteList = tags!
            
            self.assignNewTagInstanceToFrontEnd()
            
        })
        
       fetchFollowingList(completionHandler: { userArr in

        self.FollowingList = userArr!
        
        self.assignNewFollowingInstanceToFrontEnd()
   
        
        }
      
       
       )
        
        
    }
    
//  檢查字串是否符合格式
    func checkInputText() {
        let phrase = self.inputTag.text!

        let newline = NSCharacterSet.newlines
        let symbol = NSCharacterSet.symbols
        let whitespace = NSCharacterSet.whitespaces
        let whitespacesAndNewline = NSCharacterSet.whitespacesAndNewlines
        let illegalCharacter = NSCharacterSet.illegalCharacters
        let punctuationCharacter = NSCharacterSet.punctuationCharacters
        
        let stringCount = phrase.count
        
        let ifContainNewLine = phrase.rangeOfCharacter(from: newline)
        let ifContainsymbol = phrase.rangeOfCharacter(from: symbol)
        let ifContainWhitespace = phrase.rangeOfCharacter(from: whitespace)
        let ifContainWhitespacesAndNewline = phrase.rangeOfCharacter(from: whitespacesAndNewline)
        let ifContainIllegalCharacter = phrase.rangeOfCharacter(from: illegalCharacter)
        let ifContainPunctuationCharacter = phrase.rangeOfCharacter(from: punctuationCharacter)

        if ifContainWhitespace != nil ||
           ifContainNewLine != nil ||
           ifContainsymbol != nil ||
           ifContainWhitespacesAndNewline != nil ||
            ifContainIllegalCharacter != nil ||
            ifContainPunctuationCharacter != nil ||
            stringCount > 5 {
            print("format not right")
        } else {
            print("OK format")
        }

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
    
    
    
    
    func outputRandomTagInstance(tagArr: [Tag]) -> Tag {
        
        return tagArr[2]

//            shuffledArr = self.tagArr.shuffled()

        }
    
    
    @IBAction func tagSubmitBtn(_ sender: UIButton) {
//        標籤輸入規範：
//          禁止空格
//        禁止什麼都沒輸入
//        是否要禁止其他東西
        let data = ["tagContent": self.inputTag.text]
        let tab = "\t" as Character
        tab.isWhitespace
        
       
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
            checkInputText()
            db.collection("tagPoolDefault").addDocument(data: data)
         
            self.inputTag.text = ""
        }
    }
    
//   測試撈 tag 資料
    
    func fetchTag() {
        
        db.collection("tagPoolDefault").getDocuments { (querySnapshot, error) in
           if let querySnapshot = querySnapshot {
              for document in querySnapshot.documents {
//                print(document.data())
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
        
        assignNewTagInstanceToFrontEnd()
        assignNewFollowingInstanceToFrontEnd()
    }
    
    
    @IBAction func FriendBBtn(_ sender: UIButton) {
        
        actionsAfterClickFriendToVote(withUID: self.FollowingListInstance?.uid as! String, withTagContent: self.TagInstanceForVote?.tagContent as! String, withTagID: self.TagInstanceForVote?.tagID as! String)
        
        assignNewTagInstanceToFrontEnd()
        assignNewFollowingInstanceToFrontEnd()
        
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
        
        db.collection("userList").document(uid).collection("TagIGot").document(TagInstanceForVote?.tagID as! String).setData(["tagContent": TagInstanceForVote?.tagContent])
        
        db.collection("tagPoolDefault").document(tagID).updateData(["whoGotThisTag": FieldValue.arrayUnion([uid])])
        
        
        
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
