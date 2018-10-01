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
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}
