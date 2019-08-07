//
//  ChatViewController.swift
//  GroupChat
//
//  Created by KandyClients on 22.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

private struct Constants {
    static let cellIdMessageReceived = "MessageCellYou"
    static let cellIdMessageSent = "MessageCellMe"
}


class ChatViewController: UIViewController {

    @IBOutlet weak var chatTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var roomId: String!
    var messages: [DataSnapshot] = []
    var messageici: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Room Chat"
        DataService.dataService.FetchMessageFromServer(roomId: roomId) { (snap) in
            self.messages.append(snap)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func SendButtonDidTapped(_ sender: Any) {
        self.chatTextField.resignFirstResponder()
        if chatTextField.text != ""{
            if let user = Auth.auth().currentUser{
                DataService.dataService.CreateNewMessage(userId: user.uid, roomId: roomId, textMessage: chatTextField.text!)
                print("test")
            }
            else {
                let user = Auth.auth().currentUser; DataService.dataService.CreateNewMessage(userId: user!.uid, roomId: roomId, textMessage: chatTextField.text!)
            }
            self.chatTextField.text = nil
            
        }
        else {
            print("Empty Chat Error")
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let messageSnapshot = messages[indexPath.row]
        
        // let message = messageSnapshot.value as! String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellYou", for: indexPath) as! ChatTableViewCell
        let messageici = messageSnapshot.value as! String
        cell.configCell(message: messageici)
        return cell
    }
}
