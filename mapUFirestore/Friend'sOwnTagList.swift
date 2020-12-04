//
//  Friend'sOwnTagList.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit
import FirebaseFirestoreSwift

class Friend_sOwnTagList: UITableViewController {

    var tagListTheUserGot = [TagTheUserGot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTagList()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return tagListTheUserGot.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? Friend_sOwnTagListCell  else { return  UITableViewCell() }
            
        cell.tagContent.text = tagListTheUserGot[indexPath.row].tagContent!
        
        cell.numberOfLike.text = String(tagListTheUserGot[indexPath.row].numberOfThumbs!) as! String

        return cell

        }

    func loadTagList() {
        
        API.UserRef.db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").addSnapshotListener({ (querySnapshot, error) in
            
          guard let existingSnapShot = querySnapshot else {
            
            print("no result! \(error!)")
            return }
            
           
                
                for document in existingSnapShot.documents {

                   let tagContent = document.data()["tagContent"] as! String

                   let thumb = document.data()["thumbUp"] as! [String]

                   let tagID = document.documentID
                   let likedByYou = false
                   let numberOfLiked = thumb.count

                   let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent, thumbUpByYou: likedByYou)

                    self.tagListTheUserGot.append(tagListMember)
                    self.tableView.reloadData()

                }
            
            existingSnapShot.documentChanges.forEach { diff in
                  
                if (diff.type == .modified) {
                print(diff.document.data())
                
                }
                
                }
            
          
            
        })
        

        
    }
    
    
    
    typealias TagListTheUserGot = ([TagTheUserGot]?) -> Void

    //撈出tagIGot底下所有資料匯入class並作為日後存取相關資料所用
    func fetchTagListTheUserGot(completionHandler: @escaping TagListTheUserGot) {
        
        var result = [TagTheUserGot]()

        API.TagTheUserGot.fetchTagTheUserGotList { tag in
           
            result.append(tag)

                DispatchQueue.main.async() {
                    if result.isEmpty {
                        completionHandler(nil)
                    }else {
                        completionHandler(result)

                      }
        }
    }
    }
   
    
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


