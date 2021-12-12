//
//  UserModel.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/12/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    
    // MARK: - Keys
    static var idKey = "id"
    static var acceptsTextsKey = "acceptsTexts"
    static var feelingsChosenKey = "feelingsChosen"
    static var emailKey = "email"
    static var nameKey = "name"
    static var phoneNumberKey = "phoneNumber"
    
    // MARK: - Properties
    var id: Int?
    var acceptsText: Bool?
    var feelingsChosen: Bool?
    var email: String?
    var name: String?
    var phoneNumber: String?
    var sessionResponse : SessionResponse?
    
    override init(dictionary: [String : AnyObject]) {
        super.init(dictionary: dictionary)
        id = intFromObject(dictionary[UserModel.idKey])
        acceptsText = boolFromObject(dictionary[UserModel.acceptsTextsKey])
        feelingsChosen = boolFromObject(dictionary[UserModel.feelingsChosenKey])
        email = stringFromObject(dictionary[UserModel.emailKey])
        name = stringFromObject(dictionary[UserModel.nameKey] )
        phoneNumber = stringFromObject(dictionary[UserModel.phoneNumberKey])
    }
}

class SessionResponse: BaseModel {
    // MARK: - Keys
    static var status = "status"
    static var errors = "errors"
    static var loggedIn = "loggedIn"
    
    // MARK: - Properties
    var status: String?
    var errors: [String]?
    var loggedIn: Bool?
    
    override init(dictionary: [String : AnyObject]) {
        super.init(dictionary: dictionary)
        //        let result = dictionary["sessionsResponse"] as? [String: AnyObject]
        status = stringFromObject(dictionary[SessionResponse.status])
        errors = stringsArrayFromObject(dictionary[SessionResponse.errors])
        loggedIn = boolFromObject(dictionary[SessionResponse.loggedIn])
        
    }
}
