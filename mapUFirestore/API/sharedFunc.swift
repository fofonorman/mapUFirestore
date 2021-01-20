//
//  sharedFunc.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/17.
//

import Foundation
import Contacts


class sharedFunc{
    
    func loadContactData(completion: @escaping (User) -> Void) {
        //取得授權狀態
                let status = CNContactStore.authorizationStatus(for: .contacts)
                //判斷當前授權狀態
                guard status == .authorized else { print("no right to access!")
                    return }
        
        //建立通訊錄對象
                let store = CNContactStore()
                 
                //獲取Fetch,並指定要獲取聯繫人的特定屬性
                let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                            CNContactPhoneNumbersKey,
                           ]
        
        //建立請求對象
                //需要傳入一個(keysToFetch: [CNKeyDescriptor]) 包含CNKeyDescriptor類型的陣列
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                 
                //遍歷所有聯繫人
                do {
                    try store.enumerateContacts(with: request, usingBlock: {
                        (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                         
                        //取得姓名
                        let familyName = contact.familyName
                        let givenName = contact.givenName
                        print("姓名：\(familyName)\(givenName)")
                         
                        //取得電話號碼
                        print("電話：")
                        for phone in contact.phoneNumbers {
                            //取得標籤名（轉為本地看得懂的標籤，比如work、home）
                            var phoneLabel = "unknownLabel"
                            if phone.label != nil {
                                phoneLabel = CNLabeledValue<NSString>.localizedString(forLabel:
                                    phone.label!)
                            }
                             
                            //取得號碼
                            let phoneNumber = phone.value.stringValue
                            
                            let phonedata = [phoneLabel: phoneNumber]
                            var phoneDataArr: Array<Any>?
                            phoneDataArr?.append(phonedata)
                            //將聯繫資料放進 userInvirtualList 類型
//                            let userInVirtualList = User.virtualFollowingList(familyName: familyName, givenName: givenName, phone: phonedata)
                            
//                                completion(userInVirtualList)
                            print("\t\(phoneLabel)：\(phoneNumber)")
                            print(phoneDataArr)
                        }
                 
                        print("----------------")
                         
                    })
                } catch {
                    print(error)
                }
            }
    
    
}
