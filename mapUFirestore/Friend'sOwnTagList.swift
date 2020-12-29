//
//  Friend'sOwnTagList.swift
//  mapUFirestore
//
//  Created by ting pan on 2020/11/29.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

class Friend_sOwnTagList: UITableViewController, Friend_sOwnTagListCellDelegate {

    var tagListTheUserGot = [TagTheUserGot]()
    var infoFromPreviousPage: TagTheUserGot?
    var ref: DatabaseReference?
    
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
        
        if tagListTheUserGot[indexPath.row].ifRead == false {
            cell.backgroundColor = UIColor.systemGray
        } else {
            cell.backgroundColor = UIColor.systemBackground

        }

        if tagListTheUserGot[indexPath.row].thumbUpByYou == true {
            
            cell.LikeImage.setImage(UIImage(named : "afterLike"), for: UIControl.State.normal)
                        
        } else {
            
            cell.LikeImage.setImage(UIImage(named : "beforeLike"), for: UIControl.State.normal)
            
        }
        
        cell.delegate = self
        return cell

        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "GoToLikesByWhomList", sender: nil )
                
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        API.UserRef.databaseRef?.removeAllObservers()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToLikesByWhomList"{
            
        if let likesByWhomList = segue.destination as? LikesByWhomList {
            if let selectedRow = tableView.indexPathForSelectedRow?.row{
                
                likesByWhomList.infoFromPreviousPage = tagListTheUserGot[selectedRow]
                
                API.UserRef.db.collection("userList").document(API.UserRef.currentUserUID!).collection("TagIGot").document(tagListTheUserGot[selectedRow].tagID!).updateData(["ifRead": true])            }
            
            }
            
        }
        
    }
    
    func likeBtn(cell: Friend_sOwnTagListCell, numberOfLike: String) {

        if let currentUserUID = Auth.auth().currentUser?.uid{
        
        // 這一步驟，讓程式可以紀錄是哪個 cell 的按鈕被點了
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            print("no button in cell selected")
            return
          }
            
           if let selectedTagID = tagListTheUserGot[indexPath.row].tagID{

                if cell.LikeImage.currentImage == UIImage(named : "afterLike") {

                        API.UserRef.db.collection("userList").document(currentUserUID).collection("TagIGot").document(selectedTagID).updateData(["thumbUp": FieldValue.arrayRemove([currentUserUID])])
 
                    cell.LikeImage.imageView?.image = UIImage(named: "beforeLike")


                    print("revoked")
                        
                    } else {
                        API.UserRef.db.collection("userList").document(currentUserUID).collection("TagIGot").document(selectedTagID).updateData(["thumbUp": FieldValue.arrayUnion([currentUserUID])])
                        
                        cell.LikeImage.imageView?.image = UIImage(named: "afterLike")

//                        print("added")
                    }

                }else { print("no tag to thumbUp") }
        
        } else {
//            請用戶重新登入
        }

        self.tableView.reloadData()
        }

    func loadTagList() {
//        記得要取消監聽
        if let currentUserUID = Auth.auth().currentUser?.uid{
        
        API.UserRef.db.collection("userList").document(currentUserUID).collection("TagIGot").addSnapshotListener({ (querySnapshot, error) in
            
          guard let existingSnapShot = querySnapshot else {
            
            print("no result! \(error!)")
            return }
            
            existingSnapShot.documentChanges.forEach({ (documentChange) in
                
                  if documentChange.type == .added {
                    
                    if let tagContent = documentChange.document.data()["tagContent"],
                       let thumb = documentChange.document.data()["thumbUp"] as? [String],
                       let ifRead = documentChange.document.data()["ifRead"] as? Bool     {
                    
                      let tagID = documentChange.document.documentID
                      let likedByYou = thumb.contains(currentUserUID)
                      let numberOfLiked = thumb.count
                     
                        
                        let tagListMember = TagTheUserGot.TagListInMyFollowingUser(numberOfThumbs: numberOfLiked, tagID: tagID, tagContent: tagContent as! String, thumbUpByYou: likedByYou, ifRead: ifRead)
                    
                      self.tagListTheUserGot.append(tagListMember)
                    }
//                    這段對資料庫即時更新監聽並回傳資料到前端的程式碼待了解
                    } else if documentChange.type == .modified {
                        
                        if let thumb = documentChange.document.data()["thumbUp"] as? [String],
                           let ifRead = documentChange.document.data()["ifRead"] as? Bool{
                            
                            let tagID = documentChange.document.documentID
                            let numberOfLiked = thumb.count
                            let likedByYou = thumb.contains(currentUserUID)
//這段是監聽並即時更新資料至前端的關鍵程式碼，待了解
                            let tagTheUserGot = self.tagListTheUserGot.first { (tagTheUserGot) -> Bool in
                                
                                tagTheUserGot.tagID == tagID
                                
                            }
                            tagTheUserGot?.numberOfThumbs = numberOfLiked
                            tagTheUserGot?.thumbUpByYou = likedByYou
                            tagTheUserGot?.ifRead = ifRead
                        }
                        
                    }
                             
               })
            self.tableView.reloadData()
        })
    }
    
    }}
    
    
    
        

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

   


