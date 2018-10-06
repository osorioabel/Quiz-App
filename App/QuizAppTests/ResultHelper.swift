//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 10/6/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import QuizEngine

extension Result: Hashable {
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }

    public var hashValue: Int {
        return 1
    }

    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
