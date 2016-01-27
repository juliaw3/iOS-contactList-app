//
//  ContactCell.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var thumbImg: UIImageView!
    var contacts: Contacts!
    
    func configureCell(contacts: Contacts){
        self.contacts = contacts
        
        nameLbl.text = self.contacts.name
        numberLbl.text = self.contacts.number
     // ****  thumbImg.image = UIImage(named:   (need to parse the JSON for thumbimage)
        thumbImg.image = UIImage(named: "\(self.contacts.employeeId)")

        
    }
    
}
