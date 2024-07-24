//
//  PointsLabels.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI
import LaTeXSwiftUI

struct PointsLabels: View {
  
  let angles: [Double] = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]

  let points: [String] = [
    "$\\left(1, 0\\right)$",
    "$\\left(\\frac{\\sqrt{3}}{2}, \\frac{1}{2}\\right)$",
    "$\\left(\\frac{1}{\\sqrt{2}}, \\frac{1}{\\sqrt{2}}\\right)$",
    "$\\left(\\frac{1}{2}, \\frac{\\sqrt{3}}{2}\\right)$",
    "$\\left(0, 1\\right)$",
    "$\\left(-\\frac{1}{2}, \\frac{\\sqrt{3}}{2}\\right)$",
    "$\\left(-\\frac{1}{\\sqrt{2}}, \\frac{1}{\\sqrt{2}}\\right)$",
    "$\\left(-\\frac{\\sqrt{3}}{2}, \\frac{1}{2}\\right)$",
    "$\\left(-1, 0\\right)$",
    "$\\left(-\\frac{\\sqrt{3}}{2}, -\\frac{1}{2}\\right)$",
    "$\\left(-\\frac{1}{\\sqrt{2}}, -\\frac{1}{\\sqrt{2}}\\right)$",
    "$\\left(-\\frac{1}{2}, -\\frac{\\sqrt{3}}{2}\\right)$",
    "$\\left(0, -1\\right)$",
    "$\\left(\\frac{1}{2}, -\\frac{\\sqrt{3}}{2}\\right)$",
    "$\\left(\\frac{1}{\\sqrt{2}}, -\\frac{1}{\\sqrt{2}}\\right)$",
    "$\\left(\\frac{\\sqrt{3}}{2}, -\\frac{1}{2}\\right)$"
]
  var clockwise: Bool = true
  @State private var animateLabels = false

  
  var body: some View {
    GeometryReader { geometry in
      let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
      let radius = min(geometry.size.width, geometry.size.height) / 2 - 24
      
      ZStack{
        ForEach(Array(zip(angles.indices, angles)), id: \.0) { index, angle in
          let angleInRadians = (clockwise ? -1 : 1) * angle * .pi / 180
          let labelPosition = CGPoint(
            x: center.x + radius * CGFloat(cos(angleInRadians)),
            y: center.y + radius * CGFloat(sin(angleInRadians))
          )
          
          LabelView(equation: points[index])
            .position(labelPosition)
        }
      }
      .onAppear {
        animateLabels = true
      }
    }
  }
  
  private func determineRotationAngle(point: String, angle: Double) -> Double {
    if point == "0, 1" || point == "0, -1" {
      return 0
    } else if angle > 90 && angle <= 270 {
      return -angle + 180
    } else {
      return -angle
    }
  }
}

#Preview {
  PointsLabels()
}
