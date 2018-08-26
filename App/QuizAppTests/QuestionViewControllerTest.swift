//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {

    func test_viewDidLoad_rendersQuestionHeaderLabelText() {
        XCTAssertEqual(makeSUT(question: "Q1", options: []).headerLabel.text, "Q1")
    }

    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(makeSUT(options: ["A1","A2","A3"]).tableView.numberOfRows(inSection: 0), 3)
    }

    func test_viewDidLoad_withOneOptions_rendersOneOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1","A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(makeSUT(options: ["A1","A2","A3"]).tableView.title(at: 2), "A3")
    }

    func test_optionSelected_notifyDelegate() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1"]){
            receivedAnswer = $0
        }

        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(receivedAnswer, "A1")
    }

    // MARK: - Helpers
    func makeSUT(question: String = "", options: [String] = [], selection: @escaping (String) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question:question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        let cell = dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
        return cell
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
