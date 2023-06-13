//
//  File.swift
//  DailyCaloriesTests
//
//  Created by Udrea Alexandru-Iulian-Alberto on 14.06.2023.
//

import Foundation
import XCTest
@testable import DailyCalories

class ProfileViewControllerTests: XCTestCase {
    
    var profile: ProfileViewController!
    
    override func setUp() {
        super.setUp()
        profile = ProfileViewController()
        profile.loadViewIfNeeded() // Load the view hierarchy
    }
    
    override func tearDown() {
        profile = nil
        super.tearDown()
    }
    
    func testInitializationManagedObjectContextNotNil() {
        XCTAssertNotNil(profile.managedObjectContext, "managedObjectContext should not be nil.")
    }
    
    func testInitializationEmailNotEmpty() {
        XCTAssertFalse(profile.email.isEmpty)
    }
    
}
