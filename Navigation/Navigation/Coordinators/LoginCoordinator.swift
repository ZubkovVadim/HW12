import Foundation
import UIKit
import StorageService


final class LoginCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    
    private let serviceFactory: ServiceFactory
    private let moduleFactory: ModuleFactory
    private let navController: UINavigationController
    
    init(navController: UINavigationController,
         moduleFactory: ModuleFactory,
         serviceFactory: ServiceFactory) {
        self.navController = navController
        self.moduleFactory = moduleFactory
        self.serviceFactory = serviceFactory
    }
    
    func start() {
        startLogin()
    }
    
    private func startLogin() {
        let loginModule = moduleFactory.createLogin(coordinator: self)
        navController.pushViewController(loginModule, animated: true)
    }
    
    func showModule1(text: String) {
        let userService = CurrentUserService()
        let vc = ProfileViewController(userService: userService, userName: text)
        self.navController.pushViewController(vc, animated: true)
    }
}

extension LoginCoordinator: LogInViewControllerOutput {
    func didLogin(username: String) {
        showModule1(text: username)
    }
}

//            let userService = CurrentUserService()
//            let vc = ProfileViewController(userService: userService , userName: userNameTextField.text!)
//        self.navController.pushViewController(vc, animated: true)}
//        }
//        self.router.show(module)


