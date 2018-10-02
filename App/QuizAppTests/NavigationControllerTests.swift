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

    let navigationViewController = NoAnimatedNavigationViewController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationViewController, factory: self.factory)
    }()

    func test_routesSecondQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
        XCTAssertEqual(navigationViewController.viewControllers.first, viewController)
        XCTAssertEqual(navigationViewController.viewControllers.last, secondViewController)
    }

    func test_routesQuestion_presentViewControllerWithRigthCallback() {
        var callbackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback["Q1"]!("anything")
        XCTAssertTrue(callbackWasFired)
    }

    class NoAnimatedNavigationViewController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallback = [String: (String) -> Void]()

        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        func questionViewController(for question: String, answerCallback: @escaping ((String) -> Void)) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
    }
}
