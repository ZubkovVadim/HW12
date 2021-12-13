//
//  Planet.swift
//  StorageService
//
//  Created by Sergey Balashov on 06.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

public struct Planet: Decodable {
    public let name : String?
    public let rotationPeriod : String?
    public let orbitalPeriod : String?
    public let diameter : String?
    public let climate : String?
    public let gravity : String?
    public let terrain : String?
    public let surface_water : String?
    public let population : String?
    public let residents : [String]?
    public let films : [String]?
    public let created : String?
    public let edited : String?
    public let url : String?
    
    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surface_water = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        rotationPeriod = try values.decodeIfPresent(String.self, forKey: .rotationPeriod)
        orbitalPeriod = try values.decodeIfPresent(String.self, forKey: .orbitalPeriod)
        diameter = try values.decodeIfPresent(String.self, forKey: .diameter)
        climate = try values.decodeIfPresent(String.self, forKey: .climate)
        gravity = try values.decodeIfPresent(String.self, forKey: .gravity)
        terrain = try values.decodeIfPresent(String.self, forKey: .terrain)
        surface_water = try values.decodeIfPresent(String.self, forKey: .surface_water)
        population = try values.decodeIfPresent(String.self, forKey: .population)
        residents = try values.decodeIfPresent([String].self, forKey: .residents)
        films = try values.decodeIfPresent([String].self, forKey: .films)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

