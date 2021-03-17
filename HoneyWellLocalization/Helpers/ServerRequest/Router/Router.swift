//
//  Router.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
open class Router: RouterProtocol{
    
    
    var requestComposer: RequestComposerProtocol = RequestComposer()
    var encryptor = JSONEncryptor()
    var session = URLSession(configuration: .default)
    
    public init(){}
    
    public func hitServer(reuest: Request, callback: @escaping (Result<Any,Error>)->() ) throws{
        do{
            let request = try requestComposer.request(request: reuest)
            connectToServer(request: request) { [weak self] (data, _, error) in
                self?.responseHandler(data: data, error: error, callback: { (result) in
                    callback(result)
                })
            }
        }catch{
            throw error
        }
    }
    public func hitServer<T:Codable>(reuest: Request, callback: @escaping (Result<T,Error>)->() ) throws{
        do{
            let request = try requestComposer.request(request: reuest)
            connectToServer(request: request) { [weak self] (data, _, error) in
                self?.responseHandler(data: data, error: error, callback: { [weak self] (result) in
                    switch result{
                    case .success( _):
                        do{
                            if let object: T  = try self?.encryptor.encodeToObject(data: data!){
                                callback(.success(object))
                                return
                            }
                            callback(.failure( NetworkingError.unknownError ))
                            return
                        }
                        catch{
                            callback(.failure(error))
                        }
                    case .failure(let error):
                        callback(.failure(error))
                    }
                })
            }
        }catch{
            throw error
        }
    }
    
    //MARK: - connectToServer
    private func connectToServer(request: URLRequest, callback: @escaping (Data?,URLResponse?,Error?)->() ){
        session.dataTask(with: request) {  (data, response, error) in
            callback(data,response,error)
        }.resume()
    }
    
    //MARK: - handle server data
    private func responseHandler(data:Data?,error: Error?,callback: @escaping (Result<Any,Error>)->()){
        if error != nil{
             callback(.failure(error!))
             return
         }
         else if data != nil{
             do{
                let jsonData = try encryptor.convertToJSON(data: data!)
                 callback(.success(jsonData))
             }catch{
                 callback(.failure(error))
                 return
             }
         }else{
             callback(.failure(NetworkingError.unknownError))
             return
         }
        
    }
}
