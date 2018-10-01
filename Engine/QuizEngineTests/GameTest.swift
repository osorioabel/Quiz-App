//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Abel Osorio on 9/23/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
@testable import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!

    override func setUp() {
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswer: ["Q1":"A1", "Q2":"A2"])
    }

    func test_startGame_answersTwoOutOfTwoQuestionCorrectly_scoreZero() {
        router.answerCallback("A0")
        router.answerCallback("A3")

        XCTAssertEqual(router.routedResults!.score, 0)
    }

    func test_startGame_answersOneOutOfTwoQuestionCorrectly_scoreOne() {
        router.answerCallback("A1")
        router.answerCallback("A3")

        XCTAssertEqual(router.routedResults!.score, 1)
    }

    func test_startGame_answersTwotOfTwoQuestionCorrectly_score1() {

        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResults!.score, 2)
    }
}
