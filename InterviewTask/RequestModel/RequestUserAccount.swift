//
//  ProfileModel.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class RequestUserAccount: BaseModel {
    
    var name: String = ""
    var email : String = ""
    var phone_number: String = ""
    var password: String = ""
}


class UserModel: BaseModel {
    static var idKey = "id"
    static var acceptsTextsKey = "acceptsTexts"
    static var feelingsChosenKey = "feelingsChosen"
    static var emailKey = "email"
    static var nameKey = "name"
    static var phoneNumberKey = "phoneNumber"
    
    var id: Int?
    var acceptsText: Bool?
    var feelingsChosen: Bool?
    var email: String?
    var name: String?
    var phoneNumber: String?
    var error: Error?
    
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
    static var status = "status"
    static var errors = "errors"
    static var loggedIn = "loggedIn"
    
    var status: String?
    var err: String?
    var loggedIn: Bool?
    
    override init(dictionary: [String : AnyObject]) {
        super.init(dictionary: dictionary)
        let result = dictionary["sessionResponse"] as? [String: AnyObject]
        status = stringFromObject(result?[SessionResponse.status])
        err = stringFromObject(result?[SessionResponse.errors])
        loggedIn = boolFromObject(dictionary[SessionResponse.loggedIn])
        
    }
}

class ApiError: BaseModel {
    
    var status: Int?
    var meta: AnyObject?
    var sessionResponse: [SessionResponse]?
        
    override init() {
        super.init()
    }
    override init(dictionary: [String: AnyObject]) {
        super.init(dictionary: dictionary)
        status = dictionary["status"] as? Int
        meta = dictionary["meta"] as AnyObject
        
        if let tempArray = dictionary["sessionResponse"] as? Array<AnyObject> {
            sessionResponse = [SessionResponse]()
            for elem in tempArray {
                let newElem = SessionResponse(dictionary: elem as? Dictionary<String, AnyObject> ?? [:])
                sessionResponse?.append(newElem)
            }
        }
    }
}
