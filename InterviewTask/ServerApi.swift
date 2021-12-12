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
                               headers:  ["Accept": "application/json"]).responseJSON { response in
                                switch response.result {
                                case .success(let response) :
                                    if let responseDic = response as? [String : AnyObject] {
                                        let session = responseDic["sessionsResponse"] as? [String: AnyObject]
                                        let err  = SessionResponse(dictionary: session ?? [:])
                                        if  let form = responseDic["user"]  as? [String: AnyObject] {
                                            let dic = UserModel(dictionary:(form))
                                            completion(true, dic, err)
                                        } else {
                                            completion(false, nil, err)
                                        }
                                    }
                                case .failure(let errorValue):
                                    print(errorValue.localizedDescription)
                                }
        }
    }
    
    
    // MARK: - User Sign In Request
    func login(with param: RequestUserAccount,  completion: @escaping (Bool, UserModel?, SessionResponse?)->()) {
        var reqParams = params
        reqParams["email"] = param.email
        reqParams["password"] = param.password
        
        requestManager.request(baseUrlString + "/sessions",
                               method: .post,
                               parameters: reqParams,
                               encoding: JSONEncoding.default,
                               headers:  ["Accept": "application/json"]).responseJSON { response in
                                print(response)
                                switch response.result {
                                case .success(let response):
                                    if let responseDic = response as? [String : AnyObject] {
                                        var err: SessionResponse?
                                        if  let session = responseDic["sessionsResponse"] as? [String: AnyObject] {
                                            err  = SessionResponse(dictionary: session)
                                        }
                                        if  let form = responseDic["user"]  as? [String: AnyObject] {
                                            let dic = UserModel(dictionary:form)
                                            completion(true, dic, err)                                        } else {
                                            completion(false, nil, err)
                                        }
                                    }
                                case .failure(let errorValue):
                                    print(errorValue.localizedDescription)
                                }
        }
    }
}
