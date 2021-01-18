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
        //获取授权状态
                let status = CNContactStore.authorizationStatus(for: .contacts)
                //判断当前授权状态
                guard status == .authorized else { print("no right to access!")
                    return }
        
        //创建通讯录对象
                let store = CNContactStore()
                 
                //获取Fetch,并且指定要获取联系人中的什么属性
                let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                            CNContactPhoneNumbersKey,
                           ]
        
        //创建请求对象
                //需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含CNKeyDescriptor类型的数组
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                 
                //遍历所有联系人
                do {
                    try store.enumerateContacts(with: request, usingBlock: {
                        (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                         
                        //获取姓名
                        let familyName = contact.familyName
                        let givenName = contact.givenName
//                        print("姓名：\(familyName)\(givenName)")
                         
                        //获取电话号码
//                        print("电话：")
                        for phone in contact.phoneNumbers {
                            //获得标签名（转为能看得懂的本地标签名，比如work、home）
                            var phoneLabel = "unknownLabel"
                            if phone.label != nil {
                                phoneLabel = CNLabeledValue<NSString>.localizedString(forLabel:
                                    phone.label!)
                            }
                             
                            //获取号码
                            let phoneNumber = phone.value.stringValue
                            
                            let userInvirtualList = User.virtualFollowingList(familyName: familyName, givenName: givenName, phone: [phoneLabel: phoneNumber])
                            
                                completion(userInvirtualList)
//                            print("\t\(phoneLabel)：\(phoneNumber)")
                        }
                 
//                        print("----------------")
                         
                    })
                } catch {
                    print(error)
                }
            }
    
    
}
