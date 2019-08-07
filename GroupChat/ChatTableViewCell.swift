//
//  ChatTableViewCell.swift
//  GroupChat
//
//  Created by KandyClients on 23.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Foundation

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageTextLabelyou: UILabel!
    var arr = [String]()
    var uid = Auth.auth().currentUser?.uid
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    func configCell(message: String){
        
       // let arr = message.map { "\($0) \($1)" }
        
        //if(arr[0] == "\(uid) \(uid)"){
        //    self.messageTextLabel.text = arr[1]
       // }else{
      //      self.messageTextLabel.text = arr[0]
     //   }
        Database.database().reference().child("rooms").childByAutoId().child("messages").childByAutoId().child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshoTT) in
            if(snapshoTT.key == Auth.auth().currentUser?.uid){
                self.messageTextLabel.text = message
            //    self.messageTextLabel.textAlignment = .right
            }
            else {
                self.messageTextLabel.text = message
              //  self.messageTextLabel.textAlignment = .left
            }
            
        })
        self.messageTextLabel.text = message 
       
        
        
        DataService.dataService.PEOPLE_REF.child(Auth.auth().currentUser!.uid).observe(.value, with: {(snapshot) in
         
        })
    }


}
