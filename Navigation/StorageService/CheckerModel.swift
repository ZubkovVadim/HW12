
import Foundation

var checkWord: String = "пароль"

public class CheckerModel {
    static public func check(word: String?, completion: ((Bool) -> ())) {
        completion(word == checkWord)
    }
}


