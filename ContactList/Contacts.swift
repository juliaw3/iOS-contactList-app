//
//  Contacts.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import Foundation
import Alamofire

class Contacts {

    private var _name: String!
    private var _name2: String!
    private var _company: String!
    private var _number: String!
    private var _street: String!
    private var _birthdate: String!
    private var _email: String!
    private var _city: String!
    private var _state: String!
    private var _zip: String!
    private var _homePhone: String!
    private var _workPhone: String!
    private var _mobilePhone: String!
    private var _thumbImage: String!
    
    private var _favorite: Bool!
    
    private var _employeeId: Int!
    
    private var _contactUrl: String!
    
    
    var name: String {
        return _name
    }
    var employeeId: Int{
        return _employeeId
    }
    var number: String {
        return _number
    }
    
    var email: String{
        if _email == nil{
            _email = ""
        }
        return _email
    }
    
    var street: String{
        if _street == nil{
            _street = ""
        }
        return _street
    }
    var city: String{
        if _city == nil{
            _city = ""
        }
        return _city
    }
    var state: String{
        if _state == nil{
            _state = ""
        }
        return _state
    }
    var zip: String{
        if _zip == nil{
            _zip = ""
        }
        return _zip
    }
    var address: String{
        return ("\(_city) \(_state), \(_zip)")
    }
    var name2: String{
        if _name2 == nil{
            _name2 = ""
        }
        return _name2
    }
    var company: String{
        if _company == nil{
            _company = ""
        }
        return _company
    }
    var workPhone: String{
        if _workPhone == nil{
            _workPhone = ""
        }
        return _workPhone
    }
    var homePhone: String{
        if _homePhone == nil{
            _homePhone = ""
        }
        return _homePhone
    }
    var mobilePhone: String{
        if _mobilePhone == nil{
            _mobilePhone = ""
        }
        return _mobilePhone
    }
    var newBirthDate2: String{
        if _birthdate == nil{
            _birthdate = ""
        }
        return _birthdate
    }
    var sImage: String{
        return _thumbImage
    }
    var favorite: Bool{
        if _favorite == nil{
            _favorite = false
        }
        return _favorite
    }
    
    
    
    init(name: String, employeeId: Int, number: String){
        self._name = name
        self._employeeId = employeeId
        self._number = number
        
        _contactUrl = "\(URL_BASE)\(self.employeeId)\(URL_EXTENSION)"
        
    }
    
    func downloadContactDetails(completed: DownloadComplete){
        
       // self.parseJSON()
        
        let url = NSURL(string: _contactUrl)!
        Alamofire.request(.GET, url).responseJSON{response in
        let result = response.result
        
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let email = dict["email"] as? String{
                    self._email = email
                }
                
                if let favorite = dict["favorite"] as? Bool{
                    self._favorite = favorite
                }
                
                if let address = dict["address"] as? Dictionary<String, AnyObject>{
                    if let street = address["street"] as? String{
                        self._street = street
                    }
                    if let city = address["city"] as? String{
                        self._city = city
                    }
                    if let state = address["state"] as? String{
                        self._state = state
                    }
                    if let zip = address["zip"] as? String{
                        self._zip = zip
                    }
                    
                }
            }
            completed()
        }
    }
    
    func downloadContactDetails2(completed: DownloadComplete){
        let url = NSURL(string: URL_MAIN)!
        Alamofire.request(.GET, url).responseJSON{response in
            let result = response.result
            
            if let dict = result.value as? [Dictionary<String, AnyObject>] {
                if let name2 = dict[self.employeeId - 1]["name"] as? String{
                    self._name2 = name2
                    
                }
                
                if let company = dict[self.employeeId - 1]["company"] as? String{
                    self._company = company
                }
                
                if let birthdate = dict[self.employeeId - 1]["birthdate"] as? String{
                    print(birthdate)
                    let newBirthDate = Double(birthdate)!
                    let date = NSDate(timeIntervalSince1970: newBirthDate)
                    let newBirthDate2 = String(date)
                    self._birthdate = newBirthDate2
                    
                }
                if let phone = dict[self.employeeId - 1]["phone"] as? Dictionary<String, AnyObject>{
                    if let workPhone = phone["work"] as? String{
                        self._workPhone = workPhone
                    }
                    if let homePhone = phone["home"] as? String{
                        self._homePhone = homePhone
                    }
                    if let mobilePhone = phone["mobile"] as? String{
                        self._mobilePhone = mobilePhone
                    }
                }
                
            }
            completed()
    }

}
}