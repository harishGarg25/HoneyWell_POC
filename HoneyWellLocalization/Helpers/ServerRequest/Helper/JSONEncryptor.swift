//
//  JSONEncryptor.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation

class JSONEncryptor{
    
    func convertToData(dict: Any) throws -> Data{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            return jsonData
        } catch {
            throw error
        }
    }
    
    func convertToJSON(data: Data)throws -> Any{
        do {
            let decoded = try JSONSerialization.jsonObject(with: data, options: [])
            return decoded
        } catch {
            throw error
        }
    }
    
    func encodeToObject<T: Codable>(data: Data) throws -> T{
        do{
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        }
        catch{
            throw error
        }
        
    }
    
}
