//
//  ContentView.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import SwiftUI
import Combine
import CoreLocation

//import CoreLocationUI <- If we want location button (which we don't)

//Initially intended for earth weather but NASA's APIs are interesting

//https://api.nasa.gov

struct ContentView: View {
    
    //Weakify dependency if using inside class (reference type). If they're both structs it doesn't matter though "NetworkController" is a class in this case.
    
    //@StateObject and ObservedObject are similar but the view that's responsible for creating the object (and its lifecycle) should use @StateObject
    
    //@ObservableObject is the name of the protocol they both conform to
    
    @StateObject var networkController = NetworkController()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in                    
                    AnimationBackgroundContainer()
                    Spacer()
                    HStack {
                        let cityName = networkController.weatherData?.name ?? "San Francisco"
                        Text(cityName).foregroundColor(.white)
                            .padding()
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .background(
                                Rectangle().fill(.cyan.opacity(0.25)).edgesIgnoringSafeArea(.all).cornerRadius(5)
                            )
                            .frame(width: geo.size.width, height: geo.size.height / 20)
                    }.padding([.top])
                    //CloudContainer().frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    Sun().padding([.top]).offset(y: 150) //better to not hardcode this but just a test
                    Cloud().frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    VStack {
                        Spacer()
                        ResultContainerView().cornerRadius(10).frame(width: geo.size.width, height: geo.size.height / 2)
                    }
                }
            }
        }.onAppear(perform: {
            //Will want to be able to refresh this but for now just a test
            if let location = locationManager.location {
                
                print("Cur location \(location)")
            } else {
                //MARK: NOTE: This could cause retain cycle since dependency is a class, ideally don't use closures in SwiftUI structs (value types)
                
                //locationManager.requestLocation()
//                networkController.fetchOpenWeatherDataWithLocation(37, lon: -122) { result in
//                    switch result {
//                        case .success(let data):
//                            handleData(data)
//                        case .failure(let error):
//                            handleError(error)
//                        case .none:
//                            print(".none")
//                    }
//                }
                
                networkController.fetchDataAndPublish()
                
                // Task {
                    // await asyncAwaitOW()
                // }
            }
    
//            networkController.fetchDataWithResult { result in
//                switch result {
//                    case .success(let data):
//                        handleData(data)
//                    case .failure(let error):
//                        handleError(error)
//                    case .none:
//                        print(".none")
//                }
//            }
//
//            Task {
//                await asyncAwait()
//            }
            
            //returnAnyPublisher()
        }).onChange(of: networkController.weatherData, perform: { newValue in
            guard let newVal = newValue else {
                print("No change \(#function)")
                return
            }
            print("On Change Weather Data \(newVal)")
        })
        .padding()
    }
    
    func handleData(_ data: Data) {
        print("Data RES \(data)")
        print("Data RES JSON \(data.toJSONDictionary() ?? "Nada")")
    }
    
    func handleError(_ error: Error) {
        print("Error RES \(error)")
    }
    
    func asyncAwaitNASA() async {
        do {
            let someData = try await networkController.fetchDataAsyncAwaitNASA()
            print("AA Data NASA \(someData?.toJSONDictionary() ?? "Nada")")
        } catch let error {
            print("AA ERR \(error)")
        }
    }
    
    func asyncAwaitOW() async {
        do {
            let someData = try await networkController.fetchDataAsyncAwaitOW(37, lon: -122)
            print("AA Data OW \(someData?.toJSONDictionary() ?? "Nada")")
        } catch let error {
            print("AA ERR \(error)")
        }
    }
    
    func returnAnyPublisher() {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
