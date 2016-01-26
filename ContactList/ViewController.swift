//
//  ViewController.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [Contacts]()
    var inSearch = false
    var filteredSearch = [Contacts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        parseContactsCSV()
    }
    
    func parseContactsCSV(){
        
        let path = NSBundle.mainBundle().pathForResource("Contacts", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let contactId = Int(row["id"]!)!
                let name = row["name"]!
                let number = row["number"]!
                
                let contact = Contacts(name: name, employeeId: contactId, number: number)
                contacts.append(contact)
            }
            
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactCell", forIndexPath: indexPath) as? ContactCell{
            
            let contact: Contacts!
            if inSearch{
                contact = filteredSearch[indexPath.row]
            }
            else{
                contact = contacts[indexPath.row]
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
            contact = contacts[indexPath.row]
        }
        
        performSegueWithIdentifier("ContactDetailVC", sender: contact)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearch{
            return filteredSearch.count
        }
        return contacts.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake( 600, 100) ///change this to format the size of the cells correctly
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
            filteredSearch = contacts.filter({$0.name.rangeOfString(lower) != nil})
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

