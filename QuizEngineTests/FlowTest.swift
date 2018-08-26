//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {

    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }

    func test_start_withOneQuestions_routesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)
    }

    func test_start_withOneQuestions_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }

    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil

        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }

    }
}
