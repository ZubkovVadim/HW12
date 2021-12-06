//
//  JsonPlaceholderClassic.swift
//  StorageService
//
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

public class JsonPlaceholderClassic {
    public var userId : Int?
    public var id : Int?
    public var title : String?
    public var completed : Bool?
    
    public init(dictionary: [String: Any]) {
        userId = dictionary["userId"] as? Int
        id = dictionary["id"] as? Int
        title = dictionary["title"] as? String
        completed = dictionary["completed"] as? Bool
    }
}


