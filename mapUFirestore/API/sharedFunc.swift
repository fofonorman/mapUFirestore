//
//  sharedFunc.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/17.
//

import Foundation
import Contacts
import Network

class sharedFunc{
    
    func loadContactData(completion: @escaping (User, [String: Any]) -> Void) {
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
//                        print("姓名：\(familyName)\(givenName)")
                         
                        //取得電話號碼
//                        print("電話：")
                        var phoneDic = [String: String]()

                        for phone in contact.phoneNumbers {
                            //取得標籤名（轉為本地看得懂的標籤，比如work、home）
                            var phoneLabel = "unknownLabel"
                            if phone.label != nil {
                                phoneLabel = CNLabeledValue<NSString>.localizedString(forLabel:
                                    phone.label!)
                            }
                             
                            //取得號碼
                            let phoneNumber = phone.value.stringValue
                            
                            // 將所有電話號碼存到字典
                            phoneDic[phoneLabel] = phoneNumber
                            
                            //將聯繫資料放進 userInvirtualList 類型
                            let userInVirtualList = User.virtualFollowingList(familyName: familyName, givenName: givenName, phone: phoneDic)
                            
                            let contactDataInVirtualUser = [
                                 "familyName": userInVirtualList.familyName!,
                                 "givenName": userInVirtualList.givenName!,
                                 "phone": userInVirtualList.phone!
                            ] as [String: Any]
                            
                                completion(userInVirtualList, contactDataInVirtualUser)
//                             print(userInVirtualList.familyName)
//
//                            print(userInVirtualList.phone)
//                            print("\t\(phoneLabel)：\(phoneNumber)")
                        }
                       
//                        print(phoneDic)
//
//                        print("----------------")
                         
                    })
                } catch {
                    print(error)
                }
            }
    
    
    
    func checkNetworkStatus() {
        
        let monitor = NWPathMonitor()
        
//        if monitor.currentPath.status == .satisfied {
//print("有網路")
//
//        } else {
//            print("沒網路")
//        }
//
//        if monitor.currentPath.usesInterfaceType(.wifi) {
//            print("wifi")
//        } else if monitor.currentPath.usesInterfaceType(.cellular) {
//            print("cellular")
//        } else {
//            print("wierßd")
//        }
        
        monitor.pathUpdateHandler = { path in
            
            
//            switch path.status {
//
//            case .satisfied:
//                  print("good")
//            case .requiresConnection:
//                  print("need connection")
//            case .unsatisfied:
//                print("need other connection")
//
//            default:
//                print("default")
//            }
            
            if path.status == .satisfied {

                print("connected")
            } else {
                print("no connection!")
            }
            
            monitor.start(queue: DispatchQueue.global())

        }
        
    }
    
 
    
    
}
