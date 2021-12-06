import Foundation
import UIKit
import StorageService


final class LoginCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var loginFactory: LoginFactory?
    private let modelFactory: ModelFactory
    
    var navController: UINavigationController?
    
    init(modelFactory : ModelFactory) {
        self.modelFactory = modelFactory
    }
    var childCoordinators: [Coordinator] = []
    
    func start() {
        let loginController = modelFactory.createModel(with: .loginViewModel, coordinator: self) as! LogInViewController
        navController = UINavigationController(rootViewController: loginController)
        loginFactory = MyLoginFactory()
        loginController.delegate = loginFactory?.createLoginInspector()
        loginController.onModuleFinish = { [weak self] text in
            self?.showModule1(text: text)
        }
    }
    
    func showModule1(text: String) {
        let userService = CurrentUserService()
        let vc = ProfileViewController(userService: userService, userName: text)
        self.navController?.pushViewController(vc, animated: true)
    }
}

//            let userService = CurrentUserService()
//            let vc = ProfileViewController(userService: userService , userName: userNameTextField.text!)
//        self.navController.pushViewController(vc, animated: true)}
//        }
//        self.router.show(module)


