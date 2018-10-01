//
//  NavigationControllerTests.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/1/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
import UIKit
import QuizEngine
@testable import QuizApp

class NavigationControllerTests: XCTestCase {
    func test_routesToQuestion_presentViewController() {
        let navigationViewController = UINavigationController()
        let sut = NavigationControllerRouter(navigationViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        XCTAssertEqual(navigationViewController.viewControllers.count, 1)
    }

    func test_routesTwiceToQuestion_presentViewController() {
        let navigationViewController = UINavigationController()
        let sut = NavigationControllerRouter(navigationViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
    }
}
