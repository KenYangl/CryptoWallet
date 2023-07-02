//
//  LeftEdgeSwipeGestureModifier.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

//struct LeftEdgeSwipeGestureModifier: ViewModifier {
//    @GestureState private var dragState = DragState.inactive
//    @State private var isShowingView = false
//    
//    private let maxWidth: CGFloat = 100
//    private let threshold: CGFloat = 200
//    
//    func body(content: Content) -> some View {
//        content
//            .overlay(overlayView)
//            .gesture(swipeGesture)
//    }
//    
//    private var overlayView: some View {
//        Rectangle()
//            .foregroundColor(Color.blue.opacity(dragState.opacity))
//            .frame(width: dragState.width, height: UIScreen.main.bounds.height)
//            .offset(x: dragState.offset)
//            .animation(.easeInOut)
//    }
//    
//    private var swipeGesture: some Gesture {
//        DragGesture()
//            .updating($dragState) { value, state, _ in
//                let dragWidth = value.translation.width
//                state.width = max(0, min(dragWidth, maxWidth))
//                state.offset = dragWidth - maxWidth
//                state.opacity = Double(state.width / maxWidth)
//                
//                if dragWidth > threshold {
//                    isShowingView = true
//                } else if dragWidth < -threshold {
//                    isShowingView = false
//                }
//            }
//            .onEnded { value in
//                if value.translation.width > threshold {
//                    isShowingView = true
//                } else if value.translation.width < -threshold {
//                    isShowingView = false
//                }
//            }
//    }
//    
//    private enum DragState {
//        case inactive
//        
//        var width: CGFloat {
//            switch self {
//            case .inactive:
//                return 0
//            }
//        }
//        
//        var offset: CGFloat {
//            switch self {
//            case .inactive:
//                return -maxWidth
//            }
//        }
//        
//        var opacity: Double {
//            switch self {
//            case .inactive:
//                return 0
//            }
//        }
//    }
//}
