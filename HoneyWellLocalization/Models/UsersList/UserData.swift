//
//  UserData.swift
//  HoneyWellLocalization
//
//  Created by user on 18/03/21.
//  Copyright © 2021 Harish. All rights reserved.
//

import Foundation
struct UserData : Codable {
	let name : String?
	let customerId : Int?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case customerId = "customerId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
	}

}
