//
//  TableViewHelpers.swift
//  QuizAppTests
//
//  Created by Abel Osorio on 9/22/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        let cell = dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
        return cell
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }

    func select(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }

    func deselect(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: true)
        delegate?.tableView?(self, didDeselectRowAt: indexPath)
    }
}
