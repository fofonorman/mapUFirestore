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
                        //授权成功加载数据。
                        self.fetchVirtualUserPool(completion: { result in
                            self.virtualUser = result!
                            print(self.virtualUser)
                            
                        })
                        
                        
                        
//
//                        if let currentUserUID = Auth.auth().currentUser?.uid {
//                            API.UserRef.db.collection("userList").document(currentUserUID).collection("VirtualFollowingList")
//                        }
                        
                      
                        
                    }
            
            print(Auth.auth().currentUser?.uid)
            
       }
        
        // Do any additional setup after loading the view.
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
                }
            }
            
        }
    }
    

}
