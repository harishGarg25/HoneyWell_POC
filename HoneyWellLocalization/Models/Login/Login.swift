//
//  Login.swift
//  HoneyWellLocalization
//
//  Created by user on 18/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
struct Login : Codable {
	let responseCode : Int?
	let responseMsg : String?
	let isError : Bool?
	let message : String?
	let data : String?

	enum CodingKeys: String, CodingKey {

		case responseCode = "responseCode"
		case responseMsg = "responseMsg"
		case isError = "isError"
		case message = "message"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
		responseMsg = try values.decodeIfPresent(String.self, forKey: .responseMsg)
		isError = try values.decodeIfPresent(Bool.self, forKey: .isError)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		data = try values.decodeIfPresent(String.self, forKey: .data)
	}

}
