//
//  ResultContainerView.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI

//Emulate Apple's native weather app with glass effect
struct ResultContainerView : View {
    
    //@Binding var cityName : String
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    VStack {
                        Spacer()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<5) { index in
                                    Image(systemName: "pencil.circle.fill")
                                }
                            }
                        }
                        Spacer()
                        LazyVStack {
                            ForEach(0..<5) { index in
                                Text("Row \(index)")
                            }
                        }
                    }
                }
                
            }
        }.background(.cyan.opacity(0.25))
        
        //.mask(
            //LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.cyan.opacity(0.5), Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
        //)
    }
}
