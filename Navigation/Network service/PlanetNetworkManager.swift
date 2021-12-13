//
//  PlanetNetworkManager.swift
//  StorageService
//
//  Created by Sergey Balashov on 06.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import StorageService

public final class PlanetNetworkManager {
    private static let masterServiceURL: String = "https://swapi.dev"
    private static let session = URLSession.shared
    
    static func executeRequest(configuration: AppConfiguration, completion: @escaping (Planet) -> ()) {
        guard var url = URL(string: masterServiceURL) else {
            return
        }
        
        url.appendPathComponent(configuration.endpoint.path)
        
        guard var componets = URLComponents(string: url.absoluteString) else {
            return
        }
        
        componets.queryItems = configuration.endpoint.queryItems
        
        guard let url = componets.url else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error", error?.localizedDescription as Any)
                return
            }
            
            if let planet = mapToPlanet(data: data) {
                DispatchQueue.main.async {
                    completion(planet)
                }
            }
            
            let stringData = String(data: data, encoding: .utf8) ?? ""
            let allHeaderFields = (response as? HTTPURLResponse)?.allHeaderFields ?? [:]
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            print("stringData", stringData)
            print("allHeaderFields", allHeaderFields)
            print("statusCode", statusCode)
        }
        
        dataTask.resume()
    }
    
    private static func mapToPlanet(data: Data) -> Planet? {
        do {
            let planet = try JSONDecoder().decode(Planet.self, from: data)
            return planet
            
        } catch {
            print("Error serialization", error)
            return nil
        }
    }
}

