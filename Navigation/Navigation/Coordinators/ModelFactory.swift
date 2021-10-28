//
//  ModuleFactory.swift
//  Navigation
//
//  Created by Vadim on 27.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

enum ModelTypes {
    case loginViewModel
    case feedViewModel
}

protocol ModelFactoryProtocol {
    
    func createModel(with type : ModelTypes, coordinator : Coordinator ) -> UIViewController
}

class ModelFactory: ModelFactoryProtocol {
    func createModel(with type: ModelTypes, coordinator: Coordinator) -> UIViewController {
        switch type {
        case .loginViewModel :
            return LogInViewController()
        case .feedViewModel :
            return FeedViewController()
        }
    }
}

