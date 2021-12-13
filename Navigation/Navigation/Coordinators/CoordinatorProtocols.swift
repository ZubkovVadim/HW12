//
//  CoordinatorProtocols.swift
//  Navigation
//
//  Created by Vadim on 27.10.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    func start()
}

protocol  Module {
    var onModuleFinish: (() -> Void)? {get set}
}

protocol Router {
    func show(_ module: Module)
}
