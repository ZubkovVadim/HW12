
import Foundation

let checkWord: String = "123"

public class CheckerModel {
     public func check(word: String?, completion: ((Bool) -> ())) {
        completion(word == checkWord)
    }
    public init() {}
}


