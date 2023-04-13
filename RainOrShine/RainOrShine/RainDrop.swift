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
            let gradient = LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
            Circle().fill(gradient).frame(width: randomWidth, height: randomWidth)
        }
    }
}

