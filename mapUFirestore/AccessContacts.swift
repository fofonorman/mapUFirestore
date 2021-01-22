//
//  AccessContacts.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/18.
//

import UIKit
import Contacts
import FirebaseAuth

class AccessContacts: UIViewController {

    
    var virtualUser: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //匿名登入
        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                API.UserRef.db.collection("userList").document(authresult!.user.uid).setData(["55555": "555555"], merge: true)
                
            print("signed-in \(authresult!.user.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
                    if isRight {
//                        授權成功載入資料
//                        API.shared.loadContactData() {
//                            _ in return
//
//                        }
//
                        self.fetchVirtualUserPool(completion: { (result) in
//                            self.virtualUser = result
//                            var contactDataInVirtualUser = [String: Any]()

                            
                            for i in result! {
                                
                                let contactDataInVirtualUser = [
                                      "familyName": i.familyName!,
                                      "givenName": i.givenName!,
                                      "phone": i.phone!
                                ] as [String : Any]
                                
                                print(contactDataInVirtualUser)
                            }
                            print("-------------")

//                            for item in result! {
////                                print(item.phone, item.familyName)
//////                                print(self.virtualUser?.count)

//
//                                API.UserRef.db.collection("userList").document(Auth.auth().currentUser!.uid).collection("VirtualFollowingList").addDocument(data: item.phone ?? ["no value": "no value"]) { (error) in
//                                    if error == nil {
////                                        print(self.virtualUser?.count)
//                                        print("write succesfully!")
//                                    } else {
//                                        print(error?.localizedDescription)
//                                    }
//                                }
//                            }
                        })
                       
                    }
    
       }
        
        // Do any additional setup after loading the view.
    }
    
//    練習將兩顆按鈕連結到同一個IBAction
    @IBAction func testBtn(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            self.add(a: 3, b: 6)
       
        case 1:
            self.add(a: 4, b: 6)
        default:
            print("NNNNNN")
        }
        
    }
    
    func add(a: Int, b: Int) {
        print(a + b)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    typealias virtualUserClosure = ([User]?) -> Void

    func fetchVirtualUserPool(completion: @escaping virtualUserClosure) {
        var result = [User]()
        
        API.shared.loadContactData { user in
            result.append(user)
            
            DispatchQueue.main.async() {
                if result.isEmpty {
                    completion(nil)
                } else {
                    completion(result)
//                    print(result)
//                    for i in result {
//                        print(i.phone)
//
//                    }
                }
            }
            
        }
    }
    

}
