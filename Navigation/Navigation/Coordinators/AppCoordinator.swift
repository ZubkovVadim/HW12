
import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    private let serviceFactory: ServiceFactory
    private let moduleFactory: ModuleFactory
    
    // MARK: - Init

    public init(window windowRoot: UIWindow) {
        tabBarController = UITabBarController()
        window = windowRoot
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.serviceFactory = MyServiceFactory()
        self.moduleFactory = ModuleFactory(serviceFactory: serviceFactory)
    }
    

    func start() {
        let loginUnit = createLoginCoordinator()
        let feedCoordinator = FeedCoordinator()
        let infoViewController = createInfoViewController()
        
        childCoordinators.append(loginUnit.coordinator)
        childCoordinators.append(feedCoordinator)
        
        loginUnit.coordinator.parentCoordinator = self
        
        feedCoordinator.parentCoordinator = self
        loginUnit.coordinator.start()
        
        tabBarController.viewControllers = [feedCoordinator.navController,
                                            loginUnit.controller,
                                            infoViewController]
        
        let item1 = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let item2 = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        infoViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        feedCoordinator.navController.tabBarItem = item1
        loginUnit.controller.tabBarItem = item2
        
        
        //        feedCoordinator.start()
        
        
        
        
        //        if let tabController = window.rootViewController as? UITabBarController,
        //           let loginNavigation = tabController.viewControllers?.last as? UINavigationController,
        //           let loginController = loginNavigation.viewControllers.first as? LogInViewController {
        //            loginFactory = MyLoginFactory()
        //            loginController.delegate = loginFactory?.createLoginInspector() // экземпляр LoginInspector
    }
    
    func createLoginCoordinator() -> (controller: UINavigationController,
                                      coordinator: LoginCoordinator) {
        let navigation = UINavigationController()
        
        let loginCoordinator = LoginCoordinator(navController: navigation,
                                                moduleFactory: moduleFactory,
                                                serviceFactory: serviceFactory)
        
        return (navigation, loginCoordinator)
    }
    
    func createInfoViewController() -> InfoViewController {
        InfoViewController()
    }
}



