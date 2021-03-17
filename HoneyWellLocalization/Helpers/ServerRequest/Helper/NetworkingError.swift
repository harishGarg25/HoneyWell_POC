//
//  NetworkingError.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
public enum NetworkingError: Error {
    case invalidURL
    case unknownError
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("URL is not valid", comment: "NetworkingError")
        case .unknownError:
            return NSLocalizedString("Unknown Server Error", comment: "NetworkingError")
        }
    }
}
