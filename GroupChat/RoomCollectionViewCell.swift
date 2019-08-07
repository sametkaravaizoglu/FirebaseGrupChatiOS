//
//  RoomCollectionViewCell.swift
//  GroupChat
//
//  Created by KandyClients on 23.07.2019.
//  Copyright © 2019 KandyClients. All rights reserved.
//

import UIKit
import Foundation

class RoomCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var captionLbl: UILabel!
    
    func configureCell(room: Room){
        self.captionLbl.text = room.caption
        
    }
    
}
