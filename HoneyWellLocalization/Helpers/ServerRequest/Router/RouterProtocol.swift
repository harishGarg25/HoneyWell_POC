//
//  RouterProtocol.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
protocol RouterProtocol {
    var session: URLSession{get set}
    var encryptor: JSONEncryptor {get set}
    var requestComposer: RequestComposerProtocol {get set}
    
    func hitServer(reuest: Request, callback: @escaping (Result<Any,Error>)->() ) throws
    func hitServer<T:Codable>(reuest: Request, callback: @escaping (Result<T,Error>)->() ) throws
    
}
