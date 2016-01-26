//
//  Contacts.swift
//  ContactList
//
//  Created by Julia Waggoner on 1/26/16.
//  Copyright © 2016 Julia Waggoner. All rights reserved.
//

import Foundation

class Contacts {

    private var _name: String!
    private var _employeeId: Int!
    private var _number: String!
    
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
    }
    
}