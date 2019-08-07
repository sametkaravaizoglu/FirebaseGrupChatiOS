//
//  DataService.swift
//  GroupChat
//
//  Created by KandyClients on 22.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//
import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


let rootRef = Database.database().reference()

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = rootRef
    private var _ROOM_REF = rootRef.child("rooms")
    private var _MESSAGE_REF = rootRef.child("messages")
    private var _PEOPLE_REF = rootRef.child("people")
    
    var ROOM_REF: DatabaseReference{
        return _ROOM_REF
    }
    var PEOPLE_REF: DatabaseReference{
        return _PEOPLE_REF
    }
    var BASE_REF: DatabaseReference{
        return _BASE_REF
    }
    
    var MESSAGE_REF: DatabaseReference{
        return _MESSAGE_REF
    }
    
    func SignUp(username: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email,password: password, completion:{ (user,error) in
        if let error = error{
            print(error.localizedDescription)
            return
        }
            // 15.02 p3 self.PEOPLE_REF.child(Auth.auth().currentUser?.uid).setValue["username",: username,"email": email]
            let appDelegate: AppDelegate = UIApplication.shared.delegate  as! AppDelegate; appDelegate.login()
    })
  }
    
    func CreateNewRoom(user: User, caption: String){
    
        if Auth.auth().currentUser != nil{
            let idRoom = self.BASE_REF.child("roomnames").childByAutoId()
            idRoom.setValue(caption)
        }
    }
    
    func fetchDataFromServer(callback: @escaping (Room) -> ()){
        
        DataService.dataService.BASE_REF.child("roomnames").observe(.childAdded, with: {(snapshot) in
            let room = Room(key: snapshot.key, snapshot: snapshot.value as? String )
            callback(room)
            })
        }
    func CreateNewMessage(userId: String,roomId: String, textMessage: String){
        
        let idMessage = rootRef.child("messages").childByAutoId()
       // DataService.dataService.MESSAGE_REF.child(idMessage.key!).setValue([textMessage: textMessage, userId: userId])
        DataService.dataService.MESSAGE_REF.child(idMessage.key!).setValue(textMessage)
        DataService.dataService.ROOM_REF.child(roomId).child("messages").child(idMessage.key!).setValue([textMessage: textMessage, userId: userId])
    }
    
    func FetchMessageFromServer(roomId: String, callback: @escaping (DataSnapshot)->()){
        DataService.dataService.ROOM_REF.child(roomId).child("messages").observe(.childAdded, with: {(snapshot) in
            DataService.dataService.MESSAGE_REF.child(snapshot.key).observe(.value, with: {(snap) in
                callback(snap)
            })
            
        })
        
    }
    
}
