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
    static let login = ModuleApi(endPoint: "Login/login")
    static let employeeList = ModuleApi(endPoint: "Values/customers")
}

struct Requests{
    
    var requestHttpHeaders: [String:String] = [:]

    static func logInApi(params: [String : Any]) -> Request{
        var request = Request(url: APIS.login, method: .post)
        request.header = ["Content-Type" : "application/json"]
        request.body = params
        return request
    }
    
    static func employeeList(params: [String : String]) -> Request{
        
        var request = Request(url: APIS.employeeList, method: .get)
        request.header = ["Content-Type" : "application/json"]
        request.queryParam = params
        return request
    }

}


