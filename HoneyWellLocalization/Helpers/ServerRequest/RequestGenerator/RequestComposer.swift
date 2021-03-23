//
//  RequestComposer.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation


class RequestComposer: RequestComposerProtocol{
    
    var encryptor: JSONEncryptor =  JSONEncryptor()
    
    func request(request: Request)
    
    throws ->URLRequest{
        
        let urlStr = request.url.baseurl + request.url.endPoint
        let query = request.query
        let parameters = request.body
        let method = request.method
        let header = request.header
        
        guard let url = getUrl(urlStr: urlStr, queryItems: query) else{
            throw NetworkingError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        var body: Data?
        if parameters != nil{
            do{
                body = try encryptor.convertToData(dict: parameters!)
                urlRequest.httpBody = body
            }catch{
                throw error
            }
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        return urlRequest
    }
    
    //MARK: - getUrl
    private func getUrl(urlStr: String,queryItems: [Query]?)->URL?{
        
        guard var urlComponent = URLComponents(string: urlStr) else{
            return URL(string: urlStr)
        }
        var queryParam = [URLQueryItem]()
        for query in queryItems ?? []{
            let item = URLQueryItem(name: query.key, value: query.value)
            queryParam.append(item)
        }
        urlComponent.queryItems = queryParam
        return urlComponent.url
    }
}
