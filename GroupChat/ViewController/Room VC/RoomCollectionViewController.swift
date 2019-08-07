//
//  RoomCollectionViewController.swift
//  GroupChat
//
//  Created by KandyClients on 22.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage


private let reuseIdentifier = "cell"

class RoomCollectionViewController: UICollectionViewController {
    
    var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.dataService.fetchDataFromServer{(room) in
            self.rooms.append(room)
            let indexPath = IndexPath(item: self.rooms.count - 1, section: 0)
            //NSIndexPath(forItem: self.rooms.count, -1, inSection: 0)
            self.collectionView?.insertItems(at: [indexPath])
            
            
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roomCell", for: indexPath) as! RoomCollectionViewCell
        
        let room = rooms[indexPath.row]
        cell.configureCell(room: room)
        return cell
    }

    
    
    @IBAction func SignOut(_ sender: Any) {
        try!Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatSegue"{
            let cell = sender as! RoomCollectionViewCell
            let indexPath = collectionView?.indexPath(for: cell)
            let room = rooms[indexPath!.item]
            let chatViewController = segue.destination as! ChatViewController
            chatViewController.roomId = room.id
        }
    }
    }

