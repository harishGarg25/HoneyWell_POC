//
//  Apis.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation

struct ModuleApi: API{
    
    var baseurl: String
    var endPoint: String
    
    //Added dummy api URL
    init(baseUrl: String  = "http://182.75.88.147:8110/api/", endPoint: String) {
        self.baseurl = baseUrl
        self.endPoint = endPoint
    }
    
}

struct APIS {
    static let loginAPI = ModuleApi(endPoint: "Login/login")
}

struct Requests{
    
    static func logInApi(params: [String : Any]) -> Request{
        var request = Request(url: APIS.loginAPI, method: .get)
        request.body = params
        return request
    }

}
