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
    
    @State private var scrollOffset = CGPoint()
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let width = geo.size.width
                let height = geo.size.height
                OffsetObservingScrollView(offset: $scrollOffset) {
                    VStack {
                        Spacer()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<5) { index in
//                                    Spacer()
                                    let dimension = hScrollHeight - 20
                                    Image(systemName: "pencil.circle.fill").resizable().aspectRatio(contentMode: .fit).frame(width: dimension, height: dimension).opacity(0.75)
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
        }.background(.cyan.opacity(0.25)).onChange(of: scrollOffset) { val in
            hScrollHeight = 120 - val.y
            print("SCROLL OFFSET \(val) + HSCROLL HEIGHT \(hScrollHeight)")
        }
        
        //.mask(
            //LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.cyan.opacity(0.5), Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
        //)
    }
}


//Insanely enough, there is no built in way to track scroll position and perform updates, so try something like this?

//https://www.swiftbysundell.com/articles/observing-swiftui-scrollview-content-offset/


//MARK: Organize this better but just a test
struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
    key: PreferenceKey.self,
    value: geometry.frame(in: coordinateSpace).origin
)
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}

struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
    x: -newOffset.x,
    y: -newOffset.y
)
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}
