//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Abel Osorio on 10/1/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    let navigationController: UINavigationController
    let factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: answerCallback))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
            let buttonController = SubmitButtonController(button: button, callback: answerCallback)
            let controller = factory.questionViewController(for: question, answerCallback: { selection in
                buttonController.update(selection)
            })
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }
    }

    func routeTo(result: Result<Question<String>, [String]>) {
       show(factory.resultsViewController(for: result))
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    private var model: [String] = []

    init(button: UIBarButtonItem, callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }

    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }

    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }

    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }

    @objc
    private func fireCallback() {
        callback(model)
    }
}
