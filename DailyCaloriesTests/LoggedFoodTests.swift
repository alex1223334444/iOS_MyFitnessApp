//
//  LoggedFoodTests.swift
//  DailyCaloriesTests
//
//  Created by Udrea Alexandru-Iulian-Alberto on 14.06.2023.
//

import Foundation
import XCTest
@testable import DailyCalories

class LoggedFoodViewControllerTests: XCTestCase {
    
    var controller: FoodLoggedViewController!
    override func setUp() {
        super.setUp()
        controller = FoodLoggedViewController()
        controller.loadViewIfNeeded() // Load the view hierarchy
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func testInitializationManagedObjectContextNotNil() {
        XCTAssertNotNil(controller.managedObjectContext, "managedObjectContext should not be nil.")
    }
    
    func testInitializationEmailNotEmpty() {
        XCTAssertFalse(controller.email.isEmpty)
    }
    
    func testTableViewHasUser() {
        if let user = controller.fetchUser(), let email = user.email{
            XCTAssertFalse(email.isEmpty)
        }
    }
}
