//
//  ResultPresenter.swift
//  QuizApp
//
//  Created by Abel Osorio on 10/6/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import QuizEngine

struct ResultPresenter {
    let result: Result<Question<String>,[String]>
    let questions: [Question<String>]
    let correctAnswers: Dictionary<Question<String>, [String]>

    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }

    var presentableAnswer: [PresentableAnswer] {
        return questions.map { question in
            guard let userAnswer = result.answers[question], let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer to question \(question)")
            }

            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }

    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String],
                                   _ correctAnswer: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer ))
        }
    }

    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer) 
    }

    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
}
