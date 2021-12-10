//
//  LoginService.swift
//  Navigation
//
//  Created by Sergey Balashov on 10.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol LoginServing: AnyObject {
    func ckeckLogin(username: String, password: String, result: @escaping (Bool) -> ())
}

class LoginService: LoginServing {
    func ckeckLogin(username: String, password: String, result: @escaping (Bool) -> ()) {
        // Firebase ..
    }
}
