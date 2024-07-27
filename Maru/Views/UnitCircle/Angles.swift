//
//  AngleView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 6/27/24.
//

import SwiftUI

struct Angles: View {
  @State private var animateLines = false
  @State private var lineOpacity = 0.2
  @State var angles: [(start: Double, end: Double)]
  
  //optional angles array to only draw a portion of angles
  init(onlyAngles: [(start: Double, end: Double)]? = nil) {
      self._angles = State(initialValue: onlyAngles ?? [
          (0, 180), (30, 210), (45, 225), (60, 240), (90, 270), (120, 300), (135, 315), (150, 330)
      ])
  }
  
  
  
  var body: some View {
    ZStack {
      ForEach(angles, id: \.start) { angle in
        LineShape(startAngle: angle.start, endAngle: angle.end)
          .trim(from: 0, to: animateLines ? 1 : 0)
          .stroke(Color.black, lineWidth: 2)
          .opacity(animateLines ? 1 : lineOpacity)
          .animation(
            .linear(duration: 2 * (angle.end - angle.start) / 360)
            .delay(2 * angle.start / 360),
            value: animateLines
          )
          .animation(
            .linear(duration: 2 * (angle.end - angle.start) / 360)
            .delay(2 * angle.start / 360),
            value: lineOpacity
          )
      }
    }
    .onAppear {
      withAnimation {
        animateLines = true
        lineOpacity = 1.0
      }
    }
  }
}

struct LineShape: Shape {
  var startAngle: Double
  var endAngle: Double
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let startPoint = CGPoint(
      x: center.x + radius * cos(CGFloat(-startAngle * .pi / 180)),
      y: center.y + radius * sin(CGFloat(-startAngle * .pi / 180))
    )
    let endPoint = CGPoint(
      x: center.x + radius * cos(CGFloat(-endAngle * .pi / 180)),
      y: center.y + radius * sin(CGFloat(-endAngle * .pi / 180))
    )
    path.move(to: startPoint)
    path.addLine(to: endPoint)
    
    return path
  }
}


#Preview {
  Angles()
}
