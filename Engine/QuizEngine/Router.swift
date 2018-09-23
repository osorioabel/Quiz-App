//
//  Router.swift
//  QuizEngine
//
//  Created by Abel Osorio on 9/23/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
