//
//  RainDrop.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI

struct RainDrop : View {
    
    var body: some View {
        VStack {
            let randomWidth : CGFloat = .random(in: 5...30)
            let gradient = RadialGradient(gradient: Gradient(colors: [.blue, .white]), center: .center, startRadius: 2, endRadius: 650)
            Circle().fill(gradient).frame(width: randomWidth, height: randomWidth)
        }
    }
}

