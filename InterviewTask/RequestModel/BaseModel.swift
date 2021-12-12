//
//  BaseModel.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/12/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

class BaseModel {
    
    // MARK: init
    init() {}
    
    init(dictionary: [String : AnyObject]) {}
    
    // MARK: methods
    func dictionaryFromSelf() -> [String : AnyObject] {
        return Dictionary<String, AnyObject>()
    }
    
    internal func stringFromObject(_ object: AnyObject?) -> String? {
        if let object = object as? String {
            return object
        }
        return nil
    }
    
    internal func intFromObject(_ object: AnyObject?) -> Int? {
        if let object = object as? Int{
            return object
        }
        return nil
    }
    
    internal func boolFromObject(_ object: AnyObject?) -> Bool {
        if let object = object as? Bool{
            return object
        }
        return false
    }
    
    internal func stringsArrayFromObject(_ object: AnyObject?) -> [String]? {
        if let obj = object as? [String] {
            return obj
        }
        return nil
    }
}
