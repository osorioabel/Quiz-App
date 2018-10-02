//
//  Question.swift
//  QuizApp
//
//  Created by Abel Osorio on 10/2/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    var hashValue: Int {
        switch self {
        case .singleAnswer(let a):
            return a.hashValue
        case .multipleAnswer(let a):
            return a.hashValue
        }
    }

    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
