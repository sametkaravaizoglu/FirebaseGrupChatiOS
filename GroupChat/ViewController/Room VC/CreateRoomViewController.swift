//
//  CreateRoomViewController.swift
//  GroupChat
//
//  Created by KandyClients on 22.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class CreateRoomViewController: UIViewController {
    @IBOutlet weak var captionLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateRoomDidTapped(_ sender: Any) {
        DataService.dataService.CreateNewRoom(user: Auth.auth().currentUser!,caption: captionLbl.text!)
    }
    
    

}
