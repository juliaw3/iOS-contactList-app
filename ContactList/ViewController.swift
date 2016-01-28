//
//  ViewController.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    
    
    var inSearch = false
    var filteredSearch = [Contacts]()
    
    var nameOfContact = [Contacts]()
    var numberofContacts = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        

        parseJSON()
    }
    func parseJSON(){
        do{
            let data = NSData(contentsOfURL: NSURL(string: "https://solstice.applauncher.com/external/contacts.json")!)
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
           
           // let numberofContacts = jsonResult.count
            
            for anItem in jsonResult as! [Dictionary<String, AnyObject>]{
                let contacts = anItem["name"] as! String
                let contactId = anItem["employeeId"] as! Int
        
                if let phone = anItem["phone"] as? Dictionary<String, AnyObject>{
                    let work = phone["work"] as! String
                    
                    let contact = Contacts(name: contacts, employeeId: contactId, number: work)
                    nameOfContact.append(contact)
                }
                
        
            }
            
        }
        catch let error as NSError{
            print(error.debugDescription)
        }
    }
    /*
    func downloadContactDetails2(completed: DownloadComplete){
        let url = NSURL(string: URL_MAIN)!
        Alamofire.request(.GET, url).responseJSON{response in
            let result = response.result
            
            if let dict = result.value as? [Dictionary<String, AnyObject>] {
          
                if let smallImage = dict[contact.employeeId]["largeImageURL"] as? String{
                    
                
                }
            }
            completed()
        }
    }
*/
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactCell", forIndexPath: indexPath) as? ContactCell{
            
            let contact: Contacts!
            
           // let contact = nameOfContact[indexPath.row]
            
            if inSearch{
                contact = filteredSearch[indexPath.row]
            }
            else{
                contact = nameOfContact[indexPath.row]
            }
            
            
            cell.configureCell(contact)
            return cell
            
            
        }
        else{
            return UICollectionViewCell()
        }
        
    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var contact: Contacts!
        
        if inSearch{
        contact = filteredSearch[indexPath.row]
        }
        else{
            contact = nameOfContact[indexPath.row]
        }
        
        performSegueWithIdentifier("ContactDetailVC", sender: contact)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearch{
            return filteredSearch.count
        }
        return nameOfContact.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake( 600, 100)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text == nil || searchBar.text == ""{
            inSearch = false
            view.endEditing(true)
            collection.reloadData()
        }
        else{
            inSearch = true
            let lower = searchBar.text!.lowercaseString
            filteredSearch = nameOfContact.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ContactDetailVC"{
            if let detailsVC = segue.destinationViewController as? ContactDetailVC{
                if let contact = sender as? Contacts{
                    detailsVC.contacts = contact
                }
            }
        }
    }
}

