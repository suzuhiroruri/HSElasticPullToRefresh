//
//  AppDelegate.swift
//  HSElasticPullToRefreshExample
//
//  Created by Hiromasa Suzuki on 2019/05/28.
//  Copyright © 2019 Hiromasa Suzuki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let viewController = ViewController()
        let navigationController = NavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
    }

}

