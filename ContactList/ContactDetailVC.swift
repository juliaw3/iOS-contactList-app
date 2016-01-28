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
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var workPhoneLbl: UILabel!
    @IBOutlet weak var homePhoneLbl: UILabel!
    @IBOutlet weak var mobilePhoneLbl: UILabel!
    @IBOutlet weak var birthdateLbl: UILabel!
    @IBOutlet weak var image: UIImage!

    @IBOutlet weak var goldStarBtn: UIButton!
    @IBOutlet weak var silverStarBtn: UIButton!
    
    var contacts: Contacts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let img = UIImage(named: "\(self.contacts.employeeId)")
        mainImg.image = img

        
        contacts.downloadContactDetails { () -> () in
            //called when download complete
            self.updateUI()
        }
        contacts.downloadContactDetails2 { () -> () in
            self.updateUI()
        }
        
    }
    
    func updateUI(){
        emailLbl.text = contacts.email
        streetLbl.text = contacts.street
        addressLbl.text = contacts.address
        nameLbl.text = contacts.name2
        companyLbl.text = contacts.company
        workPhoneLbl.text = contacts.workPhone
        homePhoneLbl.text = contacts.homePhone
        mobilePhoneLbl.text = contacts.mobilePhone
        birthdateLbl.text = contacts.birthdate
        
        if contacts.favorite == true{
            goldStarBtn.hidden = false
            silverStarBtn.hidden = true
        }
        else{
            goldStarBtn.hidden = true
            silverStarBtn.hidden = false
        }
        


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
