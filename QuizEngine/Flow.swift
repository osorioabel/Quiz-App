//
//  Flow.swift
//  QuizEngine
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let router: Router
    let questions: [String]

    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }

    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}
