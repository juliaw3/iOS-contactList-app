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
    private var _birthday: String!
    private var _email: String!
    private var _city: String!
    private var _state: String!
    private var _zip: String!
    
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
    
    
    init(name: String, employeeId: Int, number: String){
        self._name = name
        self._employeeId = employeeId
        self._number = number
        
        _contactUrl = "\(URL_BASE)\(self.employeeId)\(URL_EXTENSION)"
        
    }
    
    func downloadContactDetails(completed: DownloadComplete){
        
        let url = NSURL(string: _contactUrl)!
        Alamofire.request(.GET, url).responseJSON{response in
        let result = response.result
        
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let email = dict["email"] as? String{
                    self._email = email
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
    
}