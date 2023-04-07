//
//  NetworkController.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI
import Combine

class NetworkController : ObservableObject {
    let baseURL = "https://api.nasa.gov/insight_weather/?api_key=\(NASA_API_KEY)&feedtype=json&ver=1.0"
    
    @Published var data : Data?
    //@Published var data : WeatherResult
    
    //"Result" is cleaner than old "data, response, error" syntax (pre async await)
    func fetchDataWithResult(completion: @escaping (_ result: Result<Data, Error>?) -> Void) {
        guard let theURL = urlFromStringWrapper() else {
            completion(nil)
            return
        }
        let request = URLRequest(url: theURL)
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil { completion(.failure(error!)) }
            if let theData = data { completion(.success(theData)) }
        }
        dataTask.resume()
    }
    
//    func fetchDataAndReturnPublisher() -> AnyPublisher<Data, Error>? {
//
//    }
    
    func fetchDataAndPublish() {
        
    }
    
    func fetchDataAsyncAwait() async throws -> Data? {
        guard let url = urlFromStringWrapper() else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func urlFromStringWrapper() -> URL?  {
        let urlFromString = URL(string: baseURL)
        guard let theURL = urlFromString else {
            return nil
        }
        return theURL
    }
}
