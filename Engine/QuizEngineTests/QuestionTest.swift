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
    func test_hasValue_withSameWrappedValue_isDifferentForSimpleAndMultipleValue() {
        let aValue = UUID()
        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue,
                          Question.multipleAnswer(aValue).hashValue)
    }

    func test_hasValue_singleAnswer() {
        let aValue = UUID()
        let anotherValue = UUID()

        XCTAssertEqual(Question.singleAnswer(aValue).hashValue,
                       Question.singleAnswer(aValue).hashValue)

        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue,
                       Question.singleAnswer(anotherValue).hashValue)
    }

    func test_hasValue_multipleAnswer() {
        let aValue = UUID()
        let anotherValue = UUID()

        XCTAssertEqual(Question.multipleAnswer(aValue).hashValue,
                       Question.multipleAnswer(aValue).hashValue)

        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue,
                          Question.multipleAnswer(anotherValue).hashValue)
    }
}
