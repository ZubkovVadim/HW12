//
//  Endpoint.swift
//  Navigation
//
//  Created by Vadim on 29.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol Endpoint {
    var method: RequestType { get }
    var path: String { get }
    var httpHeaders: [String: String] { get }
    
    var parameters: [String: Any] { get }
    var timeout: TimeInterval { get }
    var queryItems: [URLQueryItem]  { get }
}

extension Endpoint {
    var httpHeaders: [String: String] {
        switch method {
        case .get:
            return ["Cache-Control": "no-cache"]
            
        case .post, .put:
            return ["Content-Type": "application/json",
                    "Accept": "application/json",
                    "Cache-Control": "no-cache"]
        }
    }
    
    var parameters: [String : Any] { [:] }
    var timeout: TimeInterval { 30 }
    var queryItems: [URLQueryItem] { [] }
}

