//
//  ViewController.swift
//  Navigation
//
//  Created by Vadim on 29.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
}

enum AppConfiguration: Int, CaseIterable {
    case people = 0
    case starships = 1
    case planets = 2
    
    var endpoint : Endpoint {
        switch self {
        case .people :
            return GetPeopleEndpoint()
        case .starships :
            return GetStarshipsEndpoint()
        case .planets :
            return GetPlanetsEndpoint()
        }
    }
}

extension AppConfiguration {
    static func random() -> AppConfiguration {
        AppConfiguration(rawValue: Int.random(in: 0 ..< AppConfiguration.allCases.count)) ?? .people
    }
}

public enum RequestType: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
}

public final class GetPeopleEndpoint: Endpoint {
    // limit="12"
    //    var queryItems: [URLQueryItem] { [URLQueryItem(name: "limit", value: "12")] }
    var method: RequestType { .get }
    var path: String { "/api/people/8" }
}

public final class GetStarshipsEndpoint: Endpoint {
    var method: RequestType { .get }
    var path: String { "/api/starships/3" }
    //    var queryItems: [URLQueryItem] { [URLQueryItem(name: "limit", value: "12")] }
}

public final class GetPlanetsEndpoint: Endpoint {
    var method: RequestType { .get }
    var path: String { "/api/planets/1" }
    var queryItems: [URLQueryItem] { [URLQueryItem(name: "format", value: "json")] }
}


