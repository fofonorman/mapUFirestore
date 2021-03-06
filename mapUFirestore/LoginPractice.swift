//
//  LoginPractice.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/31.
//

import UIKit
import FirebaseAuth


class LoginPractice: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
  
    @IBOutlet weak var PhoneNumberField: UITextField!
    @IBOutlet weak var VerificationField: UITextField!
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var countryCode: UITextField!
    
    let countryArray: [(countryName: String, countryCode: String)] = [("AA", "+886"), ("BB", "+22"), ("CC", "+33"), ("DD", "+4"), ("EE", "+55"), ("FF", "+66")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCode.text = countryArray[0].countryCode
        countryCode.inputView = countryPicker
        updateUserStatus()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
       
             // Do any additional setup after loading the view.
    }
    
        
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCode.text = countryArray[row].countryCode
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.countryPicker.reloadAllComponents()
            self.countryPicker.isHidden = false

        }


    }
    
    
    @objc func dismissKeyboard()  {
        self.view.endEditing(true)
    }
  
    
        
        
    
      
    @IBAction func checkPhoneNumber(_ sender: Any) {
        
        guard PhoneNumberField.text != nil else {
            print("no number!")
            return }
        
        let phoneNumber = "\(countryCode.text!)" + "\(PhoneNumberField.text!)"
    
            //須再實作檢查號碼格式
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil, completion: { (verificationID, error) in
                if error == nil {
                    UserDefaults.standard.setValue(verificationID, forKey: "authVerificationID")
//                    self.showMsg(messgae: "請收簡訊")
                    self.view.endEditing(true)
                    print(phoneNumber)

                } else {
//                    可以把下方列印的錯誤訊息顯示在前端
                    print("error! \(error!.localizedDescription)")
                }
                
            })
            
        
    }
    
    
    @IBAction func checkSignIn(_ sender: Any) {
        if let verificationCode = VerificationField.text,
           let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
            Auth.auth().signIn(with: credential, completion: {(user, error) in
                if error == nil {
                    self.updateUserStatus()
                    self.view.endEditing(true)
                } else {
                    print("login failed!!")
                }
                })
            
        }
        }
    
    
    @IBAction func logOut(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
                updateUserStatus()
           } catch {
            print(error.localizedDescription)
        }
    }
    

    
    func updateUserStatus() {
//        if let user = Auth.auth().currentUser {
//            let last4Char = (user.phoneNumber! as NSString).substring(from: 9)
//
//            loginStatusLabel.text = "已登入，電話末四碼 \(last4Char)"
//
//        } else {
//            loginStatusLabel.text = "請登入"
//        }

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
