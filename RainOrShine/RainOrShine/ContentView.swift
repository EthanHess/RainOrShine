//
//  ContentView.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import SwiftUI
import Combine

//Initially intended for earth weather but NASA's APIs are interesting

//https://api.nasa.gov

struct ContentView: View {
    
    //Weakify dependency if using inside class (reference type). If they're both structs it doesn't matter though "NetworkController" is a class in this case.
    
    //@StateObject and ObservedObject are similar but the view that's responsible for creating the object (and its lifecycle) should use @StateObject
    
    //@ObservableObject is the name of the protocol they both conform to
    
    @StateObject var networkController = NetworkController()
    
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in                    
                    AnimationBackgroundContainer()
                    Spacer()
                    Text("San Francisco").foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .background(.cyan.opacity(0.25))
                        .frame(width: geo.size.width, height: geo.size.height / 20)
                        .cornerRadius(5).padding(EdgeInsets(top: geo.size.height / 10, leading: 0, bottom: 0, trailing: 0))
                    VStack {
                        Spacer()
                        ResultContainerView().cornerRadius(10).frame(width: geo.size.width, height: geo.size.height / 2)
                    }
                }
            }
        }.onAppear(perform: {
            //NOTE: This could cause retain cycle since dependency is a class
            networkController.fetchDataWithResult { result in
                switch result {
                    case .success(let data):
                        handleData(data)
                    case .failure(let error):
                        handleError(error)
                    case .none:
                        print(".none")
                    }
            }
            
            Task {
                await asyncAwait()
            }
            
            //returnAnyPublisher()
        })
        .padding()
    }
    
    func handleData(_ data: Data) {
        print("Data RES \(data)")
    }
    
    func handleError(_ error: Error) {
        print("Error RES \(error)")
    }
    
    func asyncAwait() async {
        do {
            let someData = try await networkController.fetchDataAsyncAwait()
            print("AA Data \(someData?.toJSONDictionary())")
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
