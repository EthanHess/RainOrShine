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
    @State private var scrollPosition : CGFloat = 0
    @State private var hScrollHeight : CGFloat = 120
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                ScrollView(.vertical) {
                    VStack {
                        Spacer()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<5) { index in
                                    Spacer()
                                    Image(systemName: "pencil.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).opacity(0.75)
                                    Spacer()
                                }
                            }
                        }.frame(width: width - 20, height: hScrollHeight).opacity(0.9)
                        Spacer()
                        LazyVStack {
                            ForEach(0..<5) { index in
                                Spacer()
                                Text("Row \(index)").frame(width: 200, height: 100).border(.black, width: 1).cornerRadius(3)
                                Spacer()
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


//Insanely enough, there is no built in way to track scroll position and perform updates, so try something like this?

//https://www.swiftbysundell.com/articles/observing-swiftui-scrollview-content-offset/
