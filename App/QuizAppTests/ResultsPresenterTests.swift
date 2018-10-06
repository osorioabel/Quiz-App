//
//  ResultsPresenterTests.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/6/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTests: XCTestCase {

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"],
                       Question.multipleAnswer("Q2"): ["A2", "A3"]]

        let result = Result(answers: answers, score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, correctAnswers: [:])

        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }

    func test_presentableAnswers_withWrongSingleAnswer_mapAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result(answers: answers, score: 1)

        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }

    func test_presentableAnswers_withWrongMultiple_mapAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }

    func test_presentableAnswers_withCorrectSingleAnswer_mapAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A2"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result(answers: answers, score: 1)

        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }

    func test_presentableAnswers_withRightMultiple_mapAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A2", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A4"]]
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A4")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
}
