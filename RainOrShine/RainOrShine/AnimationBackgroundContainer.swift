//
//  AnimationBackgroundContainer.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI

//Emulate Apple's native weather app with rainfall / sun in the background, will want to grab coordinates of result container though for splash effect at the top

struct AnimationBackgroundContainer : View {
    @State var startAnimation = false
    var body: some View {
        VStack {
            ZStack {
                GeometryReader { geo in
                    let size = geo.size
                    HStack(spacing: 15) {
                        ForEach(1...Int(size.width / 10), id: \.self) { _ in
                            RainDrops(size: size)
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
    
}

let constant = 50

struct RainDrops: View {

    var size : CGSize
    @State var startAnimation = false
    @State var random : Int = 0

    var body: some View {
        let randomHeight : CGFloat = .random(in: (size.height / 2)...size.height)
        VStack {
            ForEach(0..<constant, id: \.self) { index in
                //Call "getRandomIndex()" here with color update
                RainDrop()
            }
        }.mask(alignment: .top) {
            let colors : [Color] = [.clear,
                                    .cyan.opacity(0.1),
                                    .cyan.opacity(0.3),
                                    .cyan.opacity(0.5),
                                    .cyan.opacity(0.7),
                                    .cyan.opacity(0.9),
                                    .cyan]
            Rectangle().fill(
                LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
            ).frame(height: size.height / 2)
                .offset(y: startAnimation ? size.height : -randomHeight)
        }
        .onAppear {
            withAnimation(.linear(duration: 5).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
        
        //autoconnect = Automates the process of connecting or disconnecting from this connectable publisher.
        
        //.onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            //random = Int.random(in: 0..<constant)
       // }
    }
    
    func getRandomIndex(index: Int) -> Int {
        let outOfBounds = (index + random) > (constant - 1)
        if outOfBounds == true {
            if (index - random) < 0 { return index }
            return index - random
        } else {
            return index + random
        }
    }
}


