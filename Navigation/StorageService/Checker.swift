
import Foundation
import UIKit

class Checker {
    private var login: String = "Vasily"
    private var pswrd: String = "StrongPassword"
    
    func check(userName: String, password: String) -> Bool {
        if userName == login && password == pswrd {
        }
        return true
    }
    private init() {}
}
