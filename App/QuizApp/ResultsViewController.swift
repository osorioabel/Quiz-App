//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Abel Osorio on 9/22/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    private(set) var summary: String = ""
    private(set) var answers: [PresentableAnswer] = [PresentableAnswer]()

    // MARK: - Inits
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    override func viewDidLoad() {
        headerLabel.text = summary
        tableView.register(CorrectAnswerCell.self)
        tableView.register(WrongAnswerCell.self)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource protocol conformance
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return correctAnswerCell(for: answer)
        }
        return wrongAnswerCell(for: answer)
    }

    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }

    private func wrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        cell.correctAnswerLabel.text = answer.answer
        return cell
    }
}
// MARK: - UITableViewDelegate protocol conformance
extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return answers[indexPath.row].wrongAnswer == nil ? 70 : 90
    }
}
