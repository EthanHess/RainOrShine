//
//  Extensions.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/23/23.
//

import SwiftUI

//typealias JSONDict = [String: Any]

extension Data {
    func toJSONDictionary() -> Any? {
        do {
            //If we know codable type, (or using generics), create model with keys
            
            //let decoder = JSONDecoder()
            //let returnDictionary = try? decoder.decode(JSONDict.self, from: self)
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            print("\(json)")
            return json
        } catch let error {
            print("JSON error \(error.localizedDescription)")
            return nil
        }
    }
}
