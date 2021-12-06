//
//  feedCoordinator.swift
//  Navigation
//
//  Created by Vadim on 25.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


final class FeedCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: AppCoordinator?
    
    var navController: UINavigationController
    init() {
        let feedController = FeedViewController()
        navController = UINavigationController(rootViewController: feedController)
    }
    func start() {
        let moduleFeed = FeedViewController()
        navController.pushViewController(moduleFeed, animated: true)
        
        moduleFeed.onModuleFinish = { [weak self] in
            self?.showModule1()
        }
    }
    func showModule1(){
//        let module = FeedViewController()
//        module.onModuleFinish = { [weak self] in
//            self?.showModule2()
        }
}

