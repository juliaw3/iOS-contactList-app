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
    private var _company: String!
    private var _phoneNumber: String!
    private var _address: String!
    private var _birthday: String!
    private var _email: String!
    
    private var _employeeId: Int!
    
    private var _contactUrl: String!
    
    
    var name: String {
        return _name
    }
    var employeeId: Int{
        return _employeeId
    }
    var number: String {
        return _phoneNumber
    }
    
    init(name: String, employeeId: Int, number: String){
        self._name = name
        self._employeeId = employeeId
        self._phoneNumber = number
        
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
                
                print(self._email)
            }
        }
    }
    
}