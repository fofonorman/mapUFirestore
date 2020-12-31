//
//  LoginPractice.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/31.
//

import UIKit
import FirebaseAuth

class LoginPractice: UIViewController {

    @IBOutlet weak var PhoneNumberField: UITextField!
    @IBOutlet weak var VerificationField: UITextField!
    
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUserStatus()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func checkPhoneNumber(_ sender: Any) {
        if let phoneNumber = PhoneNumberField.text {
            //須再實作檢查號碼格式
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil, completion: { (verificationID, error) in
                if error == nil {
                    UserDefaults.standard.setValue(verificationID, forKey: "authVerificationID")
//                    self.showMsg(messgae: "請收簡訊")
                    self.view.endEditing(true)
                } else {
                    print("error! \(error!.localizedDescription)")
                }
                
            })
            
        }
    }
    
    
    
    
    func updateUserStatus() {
        if let user = Auth.auth().currentUser {
            let last4Char = (user.phoneNumber! as NSString).substring(from: 9)
            
            loginStatusLabel.text = "已登入，電話末四碼 \(last4Char)"
                   
        } else {
            loginStatusLabel.text = "請登入"
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
