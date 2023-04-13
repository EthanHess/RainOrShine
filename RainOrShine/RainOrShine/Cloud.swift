//
//  Cloud.swift
//  RainOrShine
//
//  Created by Ethan Hess on 4/10/23.
//

import Foundation
import SwiftUI

//TODO add wind and blow cloud
struct Cloud : View {
    var body: some View {
        HStack {
            ZStack {
                GeometryReader { geo in
                    let width = geo.size.width
                    let gradient = LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                    ForEach(1...Int(geo.size.width / 20), id: \.self) { _ in
                        let randomWidth : CGFloat = .random(in: (width / 4)...(width / 2))
                        let randomY : CGFloat = .random(in: 0...geo.size.height - randomWidth)
                        let randomX : CGFloat = .random(in: 0...width - randomWidth)
                        let randomOpacity : CGFloat = .random(in: 0...1)
                        Circle().fill(gradient).frame(width: randomWidth, height: randomWidth).offset(x: randomX, y: randomY).opacity(randomOpacity)
                    }
                }
            }
        }
    }
}
