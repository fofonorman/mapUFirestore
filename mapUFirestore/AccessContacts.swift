//
//  AccessContacts.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/18.
//

import UIKit
import Contacts
import FirebaseAuth
import Network

class AccessContacts: UIViewController {

    
    var virtualUser: [User]?
    let contactDataSetInVirtualUser = [String : Any]()
    let monitor = NWPathMonitor()

    
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
        
        
 
        API.shared.checkNetworkStatus()
        
        CNContactStore().requestAccess(for: .contacts) { (isRight, error) in
                    if isRight {
//                        授權成功載入資料
//                        API.shared.loadContactData() {
//                            (users, result) in
//
//
//                            print("-------------")
//
//                        }
//
                        self.fetchVirtualUserPool(completion: { users, result in
//                            self.virtualUser = result
//                            print(self.virtualUser)
//                            var contactDataInVirtualUser = [String: Any]()


                            for i in users! {

//                                API.UserRef.db.collection("userList").document(Auth.auth().currentUser!.uid).collection("VirtualFollowingList").addDocument(data: i.phone!) { (error) in
//                                    if error == nil {
////                                        print(self.virtualUser?.count)
//                                        print("write succesfully!")
//                                    } else {
//                                        print(error?.localizedDescription)
//                                    }
//                                }

//                                print(i.phone)
                            }
//                            print("-------------")

//                            for item in result! {
////                                print(item.phone, item.familyName)
//////                                print(self.virtualUser?.count)
                     
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
    
    typealias virtualUserClosure = ([User]?, [String: Any]?) -> Void

    func fetchVirtualUserPool(completion: @escaping virtualUserClosure) {
        var userResult = [User]()
        var contactDataSet = [String: Any]()
        
        API.shared.loadContactData { (user, contactSet) in
            userResult.append(user)
//            試著將聯繫人資料字典結構存成一個陣列
            contactDataSet = contactSet
            
            DispatchQueue.main.async() {
                if userResult.isEmpty || contactDataSet.isEmpty {
                    completion(nil, nil)
                    print("no contact!")
                } else {
                    completion(userResult, contactDataSet)
//                    print(contactDataSet)
//                    for i in contactDataSet {
//                        print(i)
//                    }
//                    print("---------")

                }
            }
            
        }
    }
    

}
