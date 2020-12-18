//
//  Friend'sOwnTagList.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class Friend_sOwnTagList: UITableViewController {

    var tagListTheUserGot = [TagTheUserGot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().signInAnonymously { (authresult,error) in
            if error == nil{
                API.UserRef.db.collection("userList").document(authresult!.user.uid).updateData(["school": "nice school",
                    "habit": "trip"]
                )
                
            print("signed-in \(authresult!.user.uid)")
           }else{
           print(error!.localizedDescription)
        }}
        
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
        
        cell.numberOfLike.text = String(tagListTheUserGot[indexPath.row].numberOfThumbs!)

        return cell

        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToLikesByWhomList", sender: nil )
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToLikesByWhomList"{
            
        if let likesByWhomList = segue.destination as? LikesByWhomList {
            if let selectedRow = tableView.indexPathForSelectedRow?.row{
                
                likesByWhomList.infoFromPreviousPage = tagListTheUserGot[selectedRow].tagID

            }
            
                
            }
            
        }
        
     
        
    }
    
    

    func loadTagList() {
//        記得要取消監聽
         
        API.UserRef.db.collection("userList").document("GOhc9KTUoSXRtPx3TKt9").collection("TagIGot").addSnapshotListener({ (querySnapshot, error) in
            
          guard let existingSnapShot = querySnapshot else {
            
            print("no result! \(error!)")
            return }
            
            existingSnapShot.documentChanges.forEach({ (documentChange) in
                
                  if documentChange.type == .added {
                    
                    if let tagContent = documentChange.document.data()["tagContent"],
                       let thumb = documentChange.document.data()["thumbUp"] as? [String] {
                    
                      let tagID = documentChange.document.documentID
                      let likedByYou = false
                      let numberOfLiked = thumb.count
                    
                      let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent as! String, thumbUpByYou: likedByYou)
                    
                      self.tagListTheUserGot.append(tagListMember)
                    }
                    } else if documentChange.type == .modified {
                        
                        if let thumb = documentChange.document.data()["thumbUp"] as? [String] {
                            
                            let tagID = documentChange.document.documentID
                            let numberOfLiked = thumb.count
                            
                            let tagTheUserGot = self.tagListTheUserGot.first { (tagTheUserGot) -> Bool in
                                
                                tagTheUserGot.tagID == tagID
                                
                            }
                            tagTheUserGot?.numberOfThumbs = numberOfLiked
                        }
                        
                    }
                             
               })
            self.tableView.reloadData()
        })
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

   


