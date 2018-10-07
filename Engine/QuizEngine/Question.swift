//
//  Question.swift
//  QuizApp
//
//  Created by Abel Osorio on 10/2/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

public enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    public var hashValue: Int {
        switch self {
        case .singleAnswer(let a):
            return a.hashValue
        case .multipleAnswer(let a):
            return a.hashValue
        }
    }
}
