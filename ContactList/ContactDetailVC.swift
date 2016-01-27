//
//  ContactDetailVC.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit

class ContactDetailVC: UIViewController {


    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    
    var contacts: Contacts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let img = UIImage(named: "\(self.contacts.employeeId)")
        mainImg.image = img

        
        contacts.downloadContactDetails { () -> () in
            //called when download complete
            self.updateUI()
            
        }
        
    }
    
    func updateUI(){
        emailLbl.text = contacts.email
        streetLbl.text = contacts.street
        addressLbl.text = contacts.address
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
