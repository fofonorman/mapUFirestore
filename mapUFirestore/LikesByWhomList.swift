//
//  LikesByWhomListTableViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/12/14.
//

import UIKit

class LikesByWhomList: UITableViewController {
    
    var likesByWhomList = [User]()
    var friendOwnTagID: String?
    var infoFromPreviousPage: TagTheUserGot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLikesByWhomList(completion: { result in
             self.likesByWhomList = result!
        })

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

            return likesByWhomList.count

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? LikesByWhomListCell else {
            return UITableViewCell()
        }
        
        cell.UserNameLabel.text = self.likesByWhomList[indexPath.row].displayName
        
        guard let photoURLString = self.likesByWhomList[indexPath.row].userAvatarURL else {
            print("no avtar URL")
            return UITableViewCell()
        }
        let photoURL = URL(string: photoURLString)
        cell.UserAvtar.sd_setImage(with: photoURL, completed: nil)
       
                return cell
    }
    
      
    typealias loadLikesByWhom = ([User]?) -> Void
    
    func loadLikesByWhomList(completion: @escaping loadLikesByWhom) {
        var result = [User]()
        
        self.friendOwnTagID = self.infoFromPreviousPage?.tagID
               
        API.UserRef.db.collection("userList").document(API.UserRef.currentUserUID!).collection("TagIGot").document(self.friendOwnTagID!).getDocument(completion:{ (querySnapshot, error) in
            
            guard let existingSnapShot = querySnapshot else {
              
              print("no result! \(error!)")
              return }
       
            if let thumbUp = existingSnapShot.data()?["thumbUp"] as? [String] {
                
                //  把有按過讚的用戶uid拿去撈用戶的頭像跟顯示名稱
            for userUID in thumbUp {

              API.UserRef.observeUser(withID: userUID, completion: { userData in result.append(userData)

                  DispatchQueue.main.async() {
                    if result.isEmpty {
                      completion(nil)
                       }else {
                      completion(result)
                       self.tableView.reloadData()
                         }
                }
                
              })}
                
            }
            
        })
    
    
        }
    
        
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
