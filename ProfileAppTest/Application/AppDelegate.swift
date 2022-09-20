//
//  AppDelegate.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 14.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let viewController = ProfileViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
        }
        return true
    }
}
