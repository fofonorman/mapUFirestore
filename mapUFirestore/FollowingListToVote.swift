//
//  FollowingListToVoteTableViewController.swift
//  mapUFirestore
//
//  Created by ting pan on 2021/1/8.
//

import UIKit
import Firebase


class FollowingListToVote: UITableViewController, FollowingListToVoteCellDelegate {
    
    var infoFromPreviousPage: [User]?
    var checkedUsers = [User]()
    var checkedUserUID: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
      
        // 導覽列右邊按鈕
        let rightButton = UIBarButtonItem(
          title:"Vote",
          style:.plain,
          target:self,
          action:#selector(FollowingListToVote.toVote)
          )
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return infoFromPreviousPage?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingListToVoteCell", for: indexPath) as? FollowingListToVoteCell else {
            return UITableViewCell()
        }
        
        cell.UserNameLabel.text = infoFromPreviousPage?[indexPath.row].displayName

        guard let photoURLString = self.infoFromPreviousPage?[indexPath.row].userAvatarURL else {
            print("no avatar!")
            return UITableViewCell()
        }
        
        let photoURL = URL(string: photoURLString)
        cell.UserAvatar.sd_setImage(with: photoURL, completed: nil)
        
        cell.checkbox.setImage(UIImage(named: "uncheckedBox"), for: UIControl.State.normal)
        
        cell.delegate = self
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        API.UserRef.databaseRef?.removeAllObservers()
    }

    @objc func toVote() {
        
        self.infoFromPreviousPage.map({ print($0) })
        
//        print(self.checkedUsers?.count)
//        InteractWithDBViewController.shared.actionsAfterClickFriendToVote(withUID: <#T##String#>, withTagContent: <#T##String#>, withTagID: <#T##String#>)
        
    }
    
    func checkboxBtn(cell: FollowingListToVoteCell, userUID: String) {

        if let currentUserUID = Auth.auth().currentUser?.uid{

        // 這一步驟，讓程式可以紀錄是哪個 cell 的按鈕被點了
        guard let indexPath = self.tableView.indexPath(for: cell),
              let selectedUser = self.infoFromPreviousPage?[indexPath.row] else {
            print("no button in cell selected")
            return
          }
            
                if cell.checkbox.currentImage == UIImage(named: "uncheckedBox") {
                    cell.checkbox.setImage(UIImage(named: "checkedbox"), for: .normal)
                    self.checkedUsers.append(selectedUser)
                    self.checkedUsers.map({ print($0.displayName!) })
                    print("this is \(selectedUser.displayName) to add")
//                    print(self.checkedUsers.count)
//                    print("go to check!")
                    print("------")
                } else {
                    cell.checkbox.setImage(UIImage(named: "uncheckedBox"), for: .normal)
                    guard let indexToDelete = self.checkedUsers.firstIndex(where: { (user) -> Bool in
                        return user.uid == selectedUser.uid
                    })
                        
                    else {
                        print("no user to delete!")
                        return
                    }
                    print("this is \(selectedUser.displayName) to delete")
                    self.checkedUsers.remove(at: indexToDelete)
                    
                    self.checkedUsers.map({ print($0.displayName )})
                    print(self.checkedUsers.count)
                    print("go to uncheck box")
                    print("------")


                }
        } else {
//            請用戶重新登入

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//    }
    

    
    

}
