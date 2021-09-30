

import Foundation
import UIKit

public protocol UserService {
    func returnUser (userName: String) -> User?
}

public class TestUserService: UserService {
    var userTest = User(fullName: "Test", avatar: UIImage(named: "test")!, status: "Only test can judge me!")
    public init() {}
    public func returnUser(userName: String) -> User? {
        return userTest
        }
    }
    

public class CurrentUserService: UserService {
    var user = User(fullName: "Bob", avatar: UIImage.init(), status: "Бог")
    public init() {}
    public func returnUser(userName: String) -> User? {
        if userName == user.fullName {
            return user
        } else {
            return nil
        }
    }
}

