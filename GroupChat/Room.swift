//
//  Room.swift
//  GroupChat
//
//  Created by KandyClients on 23.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Room{
    var caption: String!
    var id: String!
    
    init(key:String!,snapshot: String!){
        self.id = key
        self.caption = snapshot
        
        
    }
    
}


