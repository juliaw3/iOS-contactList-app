//
//  ContactDetailVC.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    var contacts: Contacts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = contacts.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
