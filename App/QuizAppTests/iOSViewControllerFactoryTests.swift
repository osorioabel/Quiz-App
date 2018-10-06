//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/6/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsViewController() {
        XCTAssertEqual(makeQuestionViewController(question: Question.singleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsViewControllerwithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: Question.singleAnswer("Q1")).options, options)
    }

    func test_questionViewController_singleAnswer_createsViewControllerwithSingleSelection() {
        let controller = makeQuestionViewController(question: Question.singleAnswer("Q1"))
        let _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_createsViewController() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_multipleAnswer_createsViewControllerwithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: Question.multipleAnswer("Q1")).options, options)
    }

    func test_questionViewController_multipleAnswer_createsViewControllerwithSingleSelection() {
        let controller = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        let _ = controller.view

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }

    // MARK: - Helpers
    func makeSUT(options: Dictionary<Question<String>, [String]>) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }

    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
