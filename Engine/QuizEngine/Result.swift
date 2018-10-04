//
//  Result.swift
//  QuizEngine
//
//  Created by Abel Osorio on 9/23/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
