
import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    // MARK: - Init
    public init(window windowRoot: UIWindow) {
        tabBarController = UITabBarController()
        window = windowRoot
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    private let modelFactory = ModelFactory()
    func start() {
        let loginCoordinator = LoginCoordinator(modelFactory: self.modelFactory)
        let feedCoordinator = FeedCoordinator()
        let infoViewController = createInfoViewController()
        
        childCoordinators.append(loginCoordinator)
        childCoordinators.append(feedCoordinator)
        
        loginCoordinator.parentCoordinator = self
        feedCoordinator.parentCoordinator = self
        loginCoordinator.start()
        tabBarController.viewControllers = [feedCoordinator.navController, loginCoordinator.navController!, infoViewController]
        
        let item1 = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let item2 = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        infoViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        feedCoordinator.navController.tabBarItem = item1
        loginCoordinator.navController?.tabBarItem = item2
        
        
        //        feedCoordinator.start()
        
        
        
        
        //        if let tabController = window.rootViewController as? UITabBarController,
        //           let loginNavigation = tabController.viewControllers?.last as? UINavigationController,
        //           let loginController = loginNavigation.viewControllers.first as? LogInViewController {
        //            loginFactory = MyLoginFactory()
        //            loginController.delegate = loginFactory?.createLoginInspector() // экземпляр LoginInspector
    }
    
    func createInfoViewController() -> InfoViewController {
        InfoViewController()
    }
}



