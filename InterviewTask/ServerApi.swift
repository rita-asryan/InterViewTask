//
//  ServerApi.swift
//  InterviewTask
//  Created by Rita Asryan on 12/10/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.

import UIKit
import Alamofire

class DataContainer {
    static let sharedInstance = ServerAPI()
}

class ServerAPI {
    private var headers:[String: String] {
        return ["Accept": "application/json"]
    }
    
    private var params: [String: String] {
        return [:]
    }
    
    private let requestManager = Alamofire.Session.default
    
    // MARK: - User Sign Up Request
    func register(with param: RequestUserAccount,  completion: @escaping (Bool, UserModel?, SessionResponse?)->()) {
        
        var reqParams = params
        reqParams["name"] = param.name
        reqParams["email"] = param.email
        reqParams["phone_number"] = param.phone_number
        reqParams["password"] = param.password
        
        requestManager.request(baseUrlString + "/users",
                               method: .post,
                               parameters: reqParams,
                               encoding: JSONEncoding.default,
                               headers:  ["Accept": "application/json"]).validate().responseJSON { response in
                                if let data = response.data {
                                    do {
                                        let result = try JSONDecoder().decode(Sessions.self, from: data)
                                        if let results = result.sessionsResponse {
                                            let dic = result.user
                                            completion(results.loggedIn, dic, results)
                                        }
                                    } catch let err{ print(err)}
                                }
        }
    }
    
    
    // MARK: - User Sign In Request
    func login(with param: RequestUserAccount,  completion: @escaping (SessionResponse?, UserModel?)->()) {
        var reqParams = params
        reqParams["email"] = param.email
        reqParams["password"] = param.password
        
        requestManager.request(baseUrlString + "/sessions",
                               method: .post,
                               parameters: reqParams,
                               encoding: JSONEncoding.default,
                               headers:  ["Accept": "application/json"]).validate().responseJSON { response in
                                if let data = response.data {
                                    do {
                                        let result = try JSONDecoder().decode(Sessions.self, from: data)
                                        if let results = result.sessionsResponse {
                                            let dic = result.user
                                            completion(results, dic)
                                        }
                                    } catch let err{ print(err)}
                                }
        }
    }
}
