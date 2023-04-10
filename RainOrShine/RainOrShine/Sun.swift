//
//  Sun.swift
//  RainOrShine
//
//  Created by Ethan Hess on 3/14/23.
//

import Foundation
import SwiftUI

struct Sun : View {
    
    var body: some View {
        VStack {
            HStack {
                Circle().fill(.yellow).frame(width: 150, height: 150, alignment: .leading)
                Spacer()
            }
        }
    }
    
    fileprivate func addRays() {
        
    }
    
    fileprivate func pulsate() {
        
    }
}
