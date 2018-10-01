//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Abel Osorio on 8/26/18.
//  Copyright © 2018 OS Mobile Lab. All rights reserved.
//

import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ResultsViewController(summary: "You got 1/2",
                                                   answers: [PresentableAnswer(question: "Q1", answer: "A1", wrongAnswer: nil),
                                                             PresentableAnswer(question: "Q2", answer: "A2", wrongAnswer: "A3")])
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
