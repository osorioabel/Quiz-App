//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Abel Osorio on 9/22/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
}

class WrongAnswerCell: UITableViewCell {
}

class ResultsViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var summary: String = ""
    private var answers: [PresentableAnswer] = [PresentableAnswer]()

    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    override func viewDidLoad() {
        headerLabel.text = summary
    }
}

// MARK: - UITableViewDataSource protocol conformance
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        return answer.isCorrect ?  CorrectAnswerCell() : WrongAnswerCell()
    }
}
