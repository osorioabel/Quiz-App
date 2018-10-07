//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Abel Osorio on 10/7/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {
        guard let index = questions.index(of: question) else {
            return ""
        }
        return "Question #\(index+1)"
    }
}
