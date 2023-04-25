//
//  NetworkController.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class NetworkController : ObservableObject {
    let baseURL = "https://api.nasa.gov/insight_weather/?api_key=\(NASA_API_KEY)&feedtype=json&ver=1.0"
    
    @Published var data : Data?
    //@Published var data : WeatherResult
    
    //MARK: --- NASA STUFF ---
    
    //"Result" is cleaner than old "data, response, error" syntax (pre async await)
    func fetchDataWithResult(completion: @escaping (_ result: Result<Data, Error>?) -> Void) {
        guard let theURL = urlFromStringWrapper(baseURL) else {
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
    
    func fetchDataAsyncAwaitNASA() async throws -> Data? {
        guard let url = urlFromStringWrapper(baseURL) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func urlFromStringWrapper(_ string: String) -> URL?  {
        let urlFromString = URL(string: string)
        guard let theURL = urlFromString else {
            return nil
        }
        return theURL
    }
    
    //MARK: --- OPEN WEATHER ---
    
    typealias OWResult = Result<Data, Error>?
    
    func fetchOpenWeatherDataWithLocation(_ lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping(_ result: OWResult) -> Void) {
        let interpolatedURLString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OPEN_WEATHER_API_KEY)"
        guard let url = urlFromStringWrapper(interpolatedURLString) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil { completion(.failure(error!)) }
            if let theData = data { completion(.success(theData)) }
        }
        dataTask.resume()
    }
    
    func fetchDataAsyncAwaitOW(_ lat: CLLocationDegrees, lon: CLLocationDegrees) async throws -> Data? {
        //Can DRY this sincer we're using it above
        let interpolatedURLString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(OPEN_WEATHER_API_KEY)"
        guard let url = urlFromStringWrapper(interpolatedURLString) else {
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
