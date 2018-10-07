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

    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [singleAnswerQuestion: ["A1"],
                       multipleAnswerQuestion: ["A2", "A3"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result(answers: answers, score: 1)
        let sut = ResultPresenter(result: result,
                                  questions: orderedQuestions,
                                  correctAnswers: [:])

        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestion_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, questions: [], correctAnswers: [:])

        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }

    func test_presentableAnswers_withWrongSingleAnswer_mapAnswer() {
        let answers = [singleAnswerQuestion: ["A1"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"]]
        let result = Result(answers: answers, score: 1)

        let sut = ResultPresenter(result: result, questions: [singleAnswerQuestion],
                                  correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }

    func test_presentableAnswers_withWrongMultiple_mapAnswer() {
        let answers = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, questions: [multipleAnswerQuestion],
                                  correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }

    func test_presentableAnswers_withTwoQuestions_mapOrderedAnswer() {
        let answers = [singleAnswerQuestion: ["A2"],
                       multipleAnswerQuestion: ["A2", "A3"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"],
                              multipleAnswerQuestion: ["A2", "A3"]]
        let orderQuestion = [singleAnswerQuestion,
                              multipleAnswerQuestion]
        let result = Result(answers: answers, score: 0)

        let sut = ResultPresenter(result: result, questions: orderQuestion, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswer.count, 2)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)

        XCTAssertEqual(sut.presentableAnswer.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.last!.answer, "A2, A3")
        XCTAssertNil(sut.presentableAnswer.last!.wrongAnswer)
    }
}
