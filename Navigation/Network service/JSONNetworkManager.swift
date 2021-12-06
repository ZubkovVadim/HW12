//
//  JSONNetworkManager.swift
//  Navigation
//
//  Created by Sergey Balashov on 06.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import StorageService

public final class JSONNetworkManager {
    private let masterServiceURL: String = "https://jsonplaceholder.typicode.com/todos/"
    private let session = URLSession.shared
    
    func getPlaceholders(completion: @escaping ([JsonPlaceholderClassic]) -> ()) {
        guard let url = URL(string: masterServiceURL) else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Error", error?.localizedDescription as Any)
                return
            }
            
            let models = self.mapToJsonPlaceholder(data: data)
            DispatchQueue.main.async {
                completion(models)
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
    
    // Data -> [{"id": 213}] -> .map { $0 == {"id": 213} } -> JsonPlaceholderClassic
    private func mapToJsonPlaceholder(data: Data) -> [JsonPlaceholderClassic] {
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [[String: Any]] ?? []
            
            return jsonArray.map { json -> JsonPlaceholderClassic in
                JsonPlaceholderClassic(dictionary: json)
            }
            
        } catch {
            print("Error serialization", error.localizedDescription)
            return []
        }
    }
}

