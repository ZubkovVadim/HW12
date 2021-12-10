//
//  LoginFactory.swift
//  Navigation
//
//  Created by Sergey Balashov on 10.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol ServiceFactory {
    func createLoginService() -> LoginServing
}

class MyServiceFactory: ServiceFactory {
    func createLoginService() -> LoginServing {
        LoginService()
    }
}

// coordinator
// module = viewModel <-> view
// service
// api parameters
