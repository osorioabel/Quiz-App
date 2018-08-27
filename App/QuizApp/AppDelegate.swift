//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = QuestionViewController(question: "abc", options: ["a1", "a2"]) { print($0) }
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = false
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
