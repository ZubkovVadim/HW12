//
//  ModuleFactory.swift
//  Navigation
//
//  Created by Vadim on 27.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

enum ModuleTypes {
    case loginViewModel
    case feedViewModel
}

protocol ModuleFactoryProtocol {
    func createLogin(coordinator: LogInViewControllerOutput) -> LogInViewController
    func createFeed(coordinator: Coordinator) -> FeedViewController
}

class ModuleFactory: ModuleFactoryProtocol {
    private let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func createLogin(coordinator: LogInViewControllerOutput) -> LogInViewController {
        LogInViewController(output: coordinator, loginService: serviceFactory.createLoginService())
    }
    
    func createFeed(coordinator: Coordinator) -> FeedViewController {
        return FeedViewController()
    }
}

