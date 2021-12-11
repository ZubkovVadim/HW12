//
//  LoginService.swift
//  Navigation
//
//  Created by Sergey Balashov on 10.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import Firebase

enum LoginError: Error {
    case nameNotFound
    case alreadyInUse
    case firebase(error: Error)
}

protocol LoginServing: AnyObject {
    func signIn(email: String, password: String, result: @escaping (Result<String, LoginError>) -> ())
    func signUp(email: String, password: String, result: @escaping (Result<String, LoginError>) -> ())
}

class LoginService: LoginServing {
    func signIn(email: String, password: String, result: @escaping (Result<String, LoginError>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                result(.failure(.firebase(error: error)))
                
            } else if let name = authResult?.user.displayName ?? authResult?.user.email {
                result(.success(name))
                
            } else {
                result(.failure(.nameNotFound))
            }
        }
    }
    
    func signUp(email: String, password: String, result: @escaping (Result<String, LoginError>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch error.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    result(.failure(.alreadyInUse))

                default:
                    result(.failure(.firebase(error: error)))
                }
                
            }else if let name = authResult?.user.displayName ?? authResult?.user.email {
                result(.success(name))
                
            } else {
                result(.failure(LoginError.nameNotFound))
            }
        }
    }
}
