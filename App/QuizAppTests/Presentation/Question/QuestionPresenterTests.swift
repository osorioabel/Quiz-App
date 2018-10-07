//
//  QuestionPresenterTests.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/7/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTests: XCTestCase {
    let question1 = Question.singleAnswer("Q1")
    let question2 = Question.multipleAnswer("Q2")

    func testTitle_ForFirstQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question1)
        XCTAssertEqual(sut.title, "Question #1")
    }

    func testTitle_ForSecondQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        XCTAssertEqual(sut.title, "Question #2")
    }

    func testTitle_ForUnexistingQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question:  Question.singleAnswer("Q1"))
        XCTAssertEqual(sut.title, "")
    }
}
