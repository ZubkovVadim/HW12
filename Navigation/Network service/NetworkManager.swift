
import Foundation
import UIKit
import WebKit

public final class NetworkManager {
    private static let masterServiceURL: String = "https://swapi.dev/api"
    private static let session = URLSession.shared
    
    static func executeRequest(configuration: AppConfiguration) {
        guard var url = URL(string: masterServiceURL) else {
            return
        }
        
        url.appendPathComponent(configuration.endpoint.path)
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error", error?.localizedDescription as Any)
                return
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
}



