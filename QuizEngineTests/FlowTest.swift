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
        
        XCTAssertEqual(router.routedQuestions, [])
    }

    func test_start_withOneQuestions_routesToCorrectQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestions_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1","Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1","Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    class RouterSpy: Router {
        var routedQuestions: [String] = []

        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }
}
