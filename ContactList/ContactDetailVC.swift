//
//  ContactDetailVC.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {


    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var cityStateZip: UILabel!

    
    
    
    
    var contacts: Contacts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLbl.text = contacts.name
        
        contacts.downloadContactDetails { () -> () in
            //called when download complete
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
