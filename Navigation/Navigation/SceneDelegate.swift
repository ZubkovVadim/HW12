
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var loginFactory: LoginFactory?
    
//    var loginInspector = LoginInspector()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let _ = (scene as? UIWindowScene) else { return }
        if let tabController = window?.rootViewController as? UITabBarController,
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

