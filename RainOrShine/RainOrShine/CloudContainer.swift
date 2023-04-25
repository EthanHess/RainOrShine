//
//  CloudContainer.swift
//  RainOrShine
//
//  Created by Ethan Hess on 4/25/23.
//

import Foundation
import SwiftUI

struct CloudContainer : View {
    @State var startAnimation = false
    var body: some View {
        HStack {
            ZStack {
                GeometryReader { geo in
                    let size = geo.size
                    HStack(spacing: 15) {
                        ForEach(1...Int(size.width / 10), id: \.self) { _ in
                            Clouds(size: size)
                        }
                    }.padding(.vertical)
                }
            }
        }
    }
}

let cloudConstant = 20

struct Clouds : View {
    var size : CGSize
    @State var startAnimation = false
    @State var random : Int = 0

    var body: some View {
        let randomWidth : CGFloat = .random(in: (size.width / 2)...size.width)
        VStack {
            ForEach(0..<cloudConstant, id: \.self) { index in
                //Call "getRandomIndex()" here with color update
                Cloud().offset(x: startAnimation ? size.width : -randomWidth)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 5).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
    }
}
