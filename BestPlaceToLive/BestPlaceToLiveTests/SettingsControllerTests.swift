//
//  SettingsControllerTests.swift
//  BestPlaceToLiveTests
//
//  Created by Jeffrey Santana on 11/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import XCTest
@testable import BestPlaceToLive

class SettingsControllerTests: XCTestCase {
	
	let user = Login(id: "123", name: "Jack Ryan", email: "jryan@cia.com", location: "Washington, DC", token: "abc")
	
	let login = LoginRequest(email: "Jack Ryan", password: "123456")

    override func setUp() {
		
    }
	
	func test1FreshInstall() {
		SettingsController.shared.isFreshInstall = true
		XCTAssertTrue(SettingsController.shared.isFreshInstall)
	}

	func test2LoginProcedure() {
		XCTAssertEqual(SettingsController.shared.loggedInUser?.name, nil)
		
		SettingsController.shared.loginProcedure(user)
		
		XCTAssertEqual(SettingsController.shared.loggedInUser?.name, user.name)
		XCTAssertEqual(SettingsController.shared.userToken, user.token)
		
	}
	
	func test3PersistCredentials() {
		SettingsController.shared.isSaveCredentials = true
		SettingsController.shared.persist(credentials: login)
		
		XCTAssertEqual(SettingsController.shared.userCredentials?.email, login.email)
	}
	
	func test4NotFreshInstall() {
		SettingsController.shared.isFreshInstall = false
		
		XCTAssertFalse(SettingsController.shared.isFreshInstall)
		XCTAssertNil(SettingsController.shared.userCredentials)
	}
	
	func test5LogoutProcedure() {
		SettingsController.shared.logoutProcedure()
		
		XCTAssertNil(SettingsController.shared.loggedInUser)
		XCTAssertNil(SettingsController.shared.userToken)
		XCTAssertNil(SettingsController.shared.userCredentials)
	}

}
