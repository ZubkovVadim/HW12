import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var feedViewController: UINavigationController!
    var loginViewController: UINavigationController!
    
    var loginFactory: LoginFactory?
    
    //    var loginInspector = LoginInspector()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        feedViewController = UINavigationController.init(rootViewController: FeedViewController())
        loginViewController = UINavigationController.init(rootViewController: LogInViewController())
        
        tabBarController.viewControllers = [feedViewController, loginViewController]
        
        let item1 = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let item2 = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        feedViewController.tabBarItem = item1
        loginViewController.tabBarItem = item2
        
        UITabBar.appearance().tintColor = UIColor(red: 0/255, green: 146/255, blue: 248/255, alpha: 1)
        
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window?.rootViewController = tabBarController
        self.window = window
        
        if let tabController = window.rootViewController as? UITabBarController,
           let loginNavigation = tabController.viewControllers?.last as? UINavigationController,
           let loginController = loginNavigation.viewControllers.first as? LogInViewController {
            loginFactory = MyLoginFactory()
            loginController.delegate = loginFactory?.createLoginInspector() // экземпляр LoginInspector
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}


