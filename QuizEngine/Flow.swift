//
//  Flow.swift
//  QuizEngine
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }

    private func routeNext(from question: String) -> ((String) -> Void) {
        return { [weak self] in self?.routeNext(question, $0) }
    }

    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex = questions.index(of: question) {
            result[question] = answer
            if currentQuestionIndex+1 < questions.count {
                let nextQuestion = questions[currentQuestionIndex+1]
                router.routeTo(question: nextQuestion, answerCallback: routeNext(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
