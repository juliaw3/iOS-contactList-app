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
    private var _employeeId: Int!
    private var _number: String!
    private var _company: String!
    private var _details: String!
    private var _birthdate: String!
    private var _workPhone: String!
    private var _homePhone: String!
    private var _mobilePhone: String!
    
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
    
    init(name: String, employeeId: Int, number: String){
        self._name = name
        self._employeeId = employeeId
        self._number = number
        
        _contactUrl = "\(URL)"
        
    }
    /*
    func downloadContactDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _contactUrl)!
        Alamofire.request(.GET, url).responseJSON{ response in
            let result = response.result
            
           // print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let employeeId = dict["employeeId"] as? Int {
                    self._employeeId = employeeId
                }
                print(self._employeeId)
            }
            
           
        }
        
    }
*/
    
}