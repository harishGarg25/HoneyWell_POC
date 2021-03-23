//
//  HoneyWellLocalizationTests.swift
//  HoneyWellLocalizationTests
//
//  Created by Harish Garg on 23/03/21.
//  Copyright © 2021 AIT. All rights reserved.
//

import XCTest
@testable import HoneyWellLocalization

class HoneyWellLocalizationTests: XCTestCase {

    func test_LoginApiResource_With_ValidRequest_Returns_LoginResponse(){

        let router = Router()
        let request = Requests.logInApi(params: ["userName": "" ,"password": "" ,"language": UserDefaults.standard.languageType ?? 1])
        let expectation = self.expectation(description: "ValidRequest_Returns_LoginResponse")
        do{
            try router.hitServer(reuest: request) { (result: Result<Login, Error>) in
                DispatchQueue.main.async
                {
                    switch result{
                    case .success(let model):
                        // ASSERT
                        XCTAssertNotNil(model)
                        XCTAssertNil(model.isError)
                        XCTAssertEqual(200, model.responseCode)
                        expectation.fulfill()
                    case .failure(let error):
                        print("error",error)
                    }
                }
            }
        }catch{
            print("catched error", error.localizedDescription)
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
