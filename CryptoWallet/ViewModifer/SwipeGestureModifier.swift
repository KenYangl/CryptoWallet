//
//  SwipeGestureModifier.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct SwipeGestureModifier: ViewModifier {
    enum DragState {
        case inactive
        case dragging(translation: CGFloat)
    }
    
    @GestureState private var dragState = DragState.inactive
    @State private var offset: CGFloat = 0
    
    private let threshold: CGFloat = 100
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset)
            .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragState) { value, state, _ in
                state = .dragging(translation: value.translation.width)
            }
            .onEnded { value in
                if value.translation.width > threshold {
                    withAnimation {
                        offset = 100
                    }
                } else {
                    withAnimation {
                        offset = 0
                    }
                }
            }
    }
}
