//
//  sharedFunc.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/17.
//

import Foundation
import Contacts


class sharedFunc{
    
    func loadContactData() {
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
                        let lastName = contact.familyName
                        let firstName = contact.givenName
                        print("姓名：\(lastName)\(firstName)")
                         
                        //获取昵称
                        let nikeName = contact.nickname
                        print("昵称：\(nikeName)")
                         
                        //获取电话号码
                        print("电话：")
                        for phone in contact.phoneNumbers {
                            //获得标签名（转为能看得懂的本地标签名，比如work、home）
                            var label = "未知标签"
                            if phone.label != nil {
                                label = CNLabeledValue<NSString>.localizedString(forLabel:
                                    phone.label!)
                            }
                             
                            //获取号码
                            let value = phone.value.stringValue
                            print("\t\(label)：\(value)")
                        }
                 
                        print("----------------")
                         
                    })
                } catch {
                    print(error)
                }
            }
    
    
}
