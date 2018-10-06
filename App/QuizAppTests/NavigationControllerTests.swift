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
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
        XCTAssertEqual(navigationViewController.viewControllers.first, viewController)
        XCTAssertEqual(navigationViewController.viewControllers.last, secondViewController)
    }

    func test_routesQuestion_presentViewControllerWithRigthCallback() {
        var callbackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true })
        factory.answerCallback[Question.singleAnswer("Q1")]!(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_routesToResults_showResultsViewController() {
        let viewController = UIViewController()
        let result = Result(answers: [Question.singleAnswer("Q1"): ["A1"]], score: 10)

        let secondViewController = UIViewController()
        let secondResult = Result(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 20)

        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)

        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(navigationViewController.viewControllers.count, 2)
        XCTAssertEqual(navigationViewController.viewControllers.first, viewController)
        XCTAssertEqual(navigationViewController.viewControllers.last, secondViewController)
    }

    class NoAnimatedNavigationViewController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubbedResults = Dictionary<Result<Question<String>, [String]>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }

        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
    }
}
