//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    private var question: String = ""
    private var options: [String] = []

    // MARK: - Life cycle
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
    }
}

// MARK: - UITableViewDataSource protocol conformance
extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}
