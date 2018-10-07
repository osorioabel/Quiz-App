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
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsViewController() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).question, "Q1")
    }

    func test_questionViewController_singleAnswer_createsViewControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion],
                                          question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_singleAnswer_createsViewControllerwithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: singleAnswerQuestion).options, options)
    }

    func test_questionViewController_singleAnswer_createsViewControllerwithSingleSelection() {
        XCTAssertFalse(makeQuestionViewController(question: singleAnswerQuestion).allowMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_createsViewController() {
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).question, "Q1")
    }

    func test_questionViewController_multipleAnswer_createsViewControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion],
                                          question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).title, presenter.title)
    }

    func test_questionViewController_multipleAnswer_createsViewControllerwithOptions() {
        XCTAssertEqual(makeQuestionViewController(question: multipleAnswerQuestion).options, options)
    }

    func test_questionViewController_multipleAnswer_createsViewControllerwithSingleSelection() {
        XCTAssertTrue(makeQuestionViewController(question: multipleAnswerQuestion).allowMultipleSelection)
    }

    func test_resultViewController_createsControllerwithSummary() {
        let results = makeResults()
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }

    func test_resultViewController_createsControllerWithPresentableAnswers() {
        let results = makeResults()
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswer.count)
    }

    // MARK: - Helpers
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:],
                 correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion],
                                        options: options,
                                        correctAnswers: correctAnswers)
    }

    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }

    func makeResults() -> (controller: ResultsViewController, presenter: ResultPresenter) {
        let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result(answers: userAnswers, score: 2)

        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)

        let controller = sut.resultsViewController(for: result) as! ResultsViewController

        return (controller: controller, presenter: presenter)
    }
}
