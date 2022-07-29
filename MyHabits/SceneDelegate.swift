//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Нияз Нуруллин on 24.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let habitsVC = HabitsViewController()
        let infoVC = InfoViewController()

        let habitsNC = UINavigationController(rootViewController: habitsVC)
        habitsNC.tabBarItem.title = "Привычки"
        habitsNC.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")

        let infoNC = UINavigationController(rootViewController: infoVC)
        infoNC.tabBarItem.title = "Информация"
        infoNC.tabBarItem.image = UIImage(systemName: "info.circle.fill")

        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [
            habitsNC,
            infoNC
        ]
        tabBarVC.tabBar.backgroundColor = .systemGray5
        tabBarVC.tabBar.tintColor = UIColor(named: "CustomViolet")

        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
        self.window = window
    }

}

