//
//  CircleView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 6/26/24.
//

import SwiftUI


struct CircleLine: View {

  @State private var animationProgress: CGFloat = 0
  @State private var animateOpacity = false
  @State private var gradientOpacity: Double = 0.2
  
  
  
  var body: some View {
    ZStack {
      Circle()
        .fill(Color.clear)
        .overlay(
          Circle()
            .trim(from: 0, to: animationProgress)
            .stroke(
              AngularGradient(
                gradient: Gradient(colors: [
                  Color.blue.opacity(gradientOpacity),
                  Color.blue
                ]),
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
              ),
              style: StrokeStyle(lineWidth: 4, lineCap: .round)
            )
            .rotationEffect(.degrees(0))
            .scaleEffect(x: 1, y: -1)
            .opacity(animateOpacity ? 1 : 0)
            .animation(.linear(duration: 2.0), value: animationProgress)
            .animation(.linear(duration: 1.0), value: animateOpacity) // Delayed opacity animation
            .animation(.linear(duration: 1.0).delay(1.2), value: gradientOpacity) // Delayed gradient opacity animation
        )
    }
    .onAppear {
      withAnimation(.linear(duration: 2.0)) {
        animationProgress = 1.0
      }
      withAnimation(.linear(duration: 1.0).delay(2.0)) {
        animateOpacity = true
      }
      withAnimation(.linear(duration: 1.0).delay(3.0)) {
        gradientOpacity = 1.0
      }
    }
  }
}

#Preview {
  CircleLine()
}
