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
    let router = RouterSpy()

    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions:[]).start()

        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    func test_start_withOneQuestions_routesToCorrectQuestion() {
        makeSUT(questions:["Q1"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_start_withOneQuestions_routesToCorrectQuestion_2() {
        makeSUT(questions:["Q2"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let sut = makeSUT(questions:["Q1","Q2"])

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions:["Q1","Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }

    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToThirdQuestion() {
        let sut = makeSUT(questions:["Q1","Q2","Q3"])
        sut.start()

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2","Q3"])
    }

    func test_startAndAnswerFirst_withOneQuestions_doesNotRoutesToAnotherQuestion() {
        let sut = makeSUT(questions:["Q1"])
        sut.start()

        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startWithNoQuestions_routesToResults() {
        let sut = makeSUT(questions:[])
        sut.start()

        XCTAssertEqual(router.routedResults!.answers, [:])
    }

    func test_startWithOneQuestions_doesNotRoutesToResults() {
        makeSUT(questions:["Q1"]).start()

        XCTAssertNil(router.routedResults)
    }

    func test_startAndAnwserFirstQuestion_WithTwoQuestions_doesNotRoutesToResults() {
        let sut = makeSUT(questions:["Q1","Q2"])
        sut.start()

        router.answerCallback("A1")

        XCTAssertNil(router.routedResults)
    }

    func test_startAndAnwserFirstAndSecondQuestion_WithTwoQuestions_routesToResults() {
        let sut = makeSUT(questions:["Q1","Q2"])
        sut.start()

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults!.answers, ["Q1":"A1", "Q2":"A2"])
    }

    func test_startAndAnwserFirstAndSecondQuestion_WithTwoQuestions_scores() {
        let sut = makeSUT(questions:["Q1","Q2"], scoring: { _ in 10 })
        sut.start()

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults!.answers, ["Q1":"A1", "Q2":"A2"])
        XCTAssertEqual(router.routedResults!.score, 10)
    }

    func test_startAndAnwserFirstAndSecondQuestion_WithTwoQuestions_scoresWithRightAnswers() {
        var receiveAnswers = [String: String]()
        let sut = makeSUT(questions:["Q1","Q2"], scoring: { answer in
            receiveAnswers = answer
            return 20 })
        sut.start()

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults!.answers, ["Q1":"A1", "Q2":"A2"])
        XCTAssertEqual(receiveAnswers, ["Q1":"A1", "Q2":"A2"])
    }

    // MARK: - Helpers

    func makeSUT(questions: [String],
                 scoring: @escaping (([String: String]) -> Int) = { _ in 10 }) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
}
