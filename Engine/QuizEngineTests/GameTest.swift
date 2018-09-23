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
    func test_startGame_answersOneOutOfTwoQuestionCorrectly_score1() {
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswer: ["Q1":"A1", "Q2":"A2"])

        router.answerCallback("A1")
        router.answerCallback("A3")

        XCTAssertEqual(router.routedResults!.score, 1)
    }
}
