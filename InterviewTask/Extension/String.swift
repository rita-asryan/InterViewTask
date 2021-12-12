//
//  String.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                return  false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
   func isValidPassword() -> Bool {
        if self.count < 8  {
            return false
        }
        return true
    }
    
    func isValidPhone() -> Bool {
        if self.count < 10 {
            return false
        }
        return true
    }
}
