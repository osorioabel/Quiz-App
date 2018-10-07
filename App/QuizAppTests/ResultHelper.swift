//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/6/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

@testable import QuizEngine

extension Result: Hashable {
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result {
        return Result(answers: answers, score: score)
    }

    public var hashValue: Int {
        return 1
    }

    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
