//
//  SwipeGestureModifier.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-05.
//


import SwiftUI


struct SwipeGestureModifier : ViewModifier {
    @Binding var swipeDirection: SwipeDirection
    
    @State var cardRemovalTransition = AnyTransition.trailingBottom
    var dragAreaThreshold: CGFloat = 40.0
    @GestureState var dragState = DragState.inactive
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
            case .pressing, .inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .animation(.easeInOut(duration: 0.5), value: 1.0)
            .gesture(LongPressGesture(minimumDuration: 0.01)
                .sequenced(before: DragGesture())
                .updating(self.$dragState, body: { (value, state, transaction) in
                    switch value {
                    case .first(true):
                        state = .pressing
                    case .second(true, let drag):
                        state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                        break
                    }
                })
                    .onChanged({ (value) in
                        guard case .second(true, let drag?) = value else {
                            return
                        }
                        
                        if drag.translation.width < -self.dragAreaThreshold {
                            self.cardRemovalTransition = .leadingBottom
                        }
                        
                        if drag.translation.width > self.dragAreaThreshold {
                            self.cardRemovalTransition = .trailingBottom
                        }
                    })
                        .onEnded({ (value) in
                            guard case .second(true, let drag?) = value else {
                                return
                            }
                            // reset to check if the swiping is allowed
                            swipeDirection = .notAllow
                            // Note : translation refer to MeasureDetailSheet
                            if drag.translation.width < -80 && (drag.translation.height > -50 && drag.translation.height < 50){
                                swipeDirection = .left
                            } else if drag.translation.width > 40 && drag.translation.height > -50 && drag.translation.height < 50{
                                swipeDirection = .right
                            } else if ((drag.translation.width < 0) && drag.translation.width < self.dragAreaThreshold)  {
                                swipeDirection = .up
                            } else if ((drag.translation.width > 0) && drag.translation.width < self.dragAreaThreshold)  {
                                swipeDirection = .down
                            }
                            
                        })
            ).transition(self.cardRemovalTransition)
        
    }
}


// Note: - Swipe CardTransition
extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}

enum SwipeDirection {
    case left
    case right
    case up
    case down
    case notAllow
}


