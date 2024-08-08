//
//  DraggableAnswerView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 8/8/24.
//

//import SwiftUI
//struct ViewPositionKey: PreferenceKey {
//  static var defaultValue: CGRect = .zero
//  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//    value = nextValue()
//  }
//}
//struct AnswerView: View {
//    let answer: DraggableAnswer
//    let isDragged: Bool
//    let dragOffset: CGSize
//    let viewPosition: Binding<CGRect>
//    let onDragChanged: (DragGesture.Value) -> Void
//    let onDragEnded: (DragGesture.Value) -> Void
//
//    var body: some View {
//        ScaledUnitCirclePoint(point: answer.ScaledPoint.point)
//            .id(answer.id)
//            .offset(isDragged ? dragOffset : .zero)
//            .background(
//                GeometryReader { geometry in
//                    Color.clear
//                        .preference(key: ViewPositionKey.self, value: geometry.frame(in: .global))
//                }
//            )
//            .onPreferenceChange(ViewPositionKey.self) { newPosition in
//                viewPosition.wrappedValue = newPosition
//            }
//            .gesture(
//                DragGesture(minimumDistance: 0.1)
//                    .onChanged(onDragChanged)
//                    .onEnded(onDragEnded)
//            )
//    }
//}
