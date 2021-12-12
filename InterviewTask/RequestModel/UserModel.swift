//
//  UserModel.swift
//  InterviewTask
//
//  Created by Rita Asryan on 12/12/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//

import UIKit

struct UserModel: Codable {
    var id: Int!
    var acceptsText: Bool!
    var feelingsChosen: Bool!
    var email: String!
    var name: String!
    var phoneNumber: String!
}

struct SessionResponse: Codable {
    var status: String!
    var errors: [String]!
    var loggedIn: Bool!
    
}

struct Sessions: Codable {
    var sessionsResponse: SessionResponse!
    var user: UserModel!
}
