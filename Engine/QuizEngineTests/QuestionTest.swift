//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/2/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
@testable import QuizEngine

class QuestionTest: XCTestCase {
    func test_hasValue_singleAnswer_returnsHashValue() {
        let type = "A question"

        let sut = Question.singleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }

    func test_hasValue_multipleAnswer_returnsHashValue() {
        let type = "A question"

        let sut = Question.multipleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
}
