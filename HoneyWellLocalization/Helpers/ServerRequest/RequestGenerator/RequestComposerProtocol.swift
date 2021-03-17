//
//  RequestComposerProtocol.swift
//  HoneyWellLocalization
//
//  Created by user on 16/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
protocol RequestComposerProtocol {
    var encryptor: JSONEncryptor {get set}
    func request(request: Request) throws ->URLRequest
}
