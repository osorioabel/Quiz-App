//
//  Game.swift
//  QuizEngine
//
//  Created by Abel Osorio on 9/23/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

public func startGame<Question, Answer, R: Router >(questions: [Question],
                                                              router: R,
                                                              correctAnswer: [Question: Answer]) where R.Question == Question, R.Answer == Answer {

}
