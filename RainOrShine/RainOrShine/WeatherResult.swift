//
//  WeatherResult.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation

struct WeatherResult: Codable, Equatable {
    var base : String = ""
    //var clouds <- TODO add nested data
    var cod : Int = 0
    //var coord
    var dt : Int = 0
    var id : Int = 0
    //var main
    var name : String = ""
    //var sys
    var timezone : Int = 0
    var visibility : Int = 0
    //var weather
    //var wind
    
    enum CodingKeys: String, CodingKey {
        case base
        case cod
        case dt
        case id
        case name
        case timezone
        case visibilty
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        base = try values.decodeIfPresent(String.self, forKey: .base) ?? ""
        cod = try values.decodeIfPresent(Int.self, forKey: .cod) ?? 0
        dt = try values.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone) ?? 0
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibilty) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode (base, forKey: .base)
        try container.encode (cod, forKey: .cod)
        try container.encode (dt, forKey: .dt)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (timezone, forKey: .timezone)
        try container.encode (visibility, forKey: .visibilty)
    }
}
