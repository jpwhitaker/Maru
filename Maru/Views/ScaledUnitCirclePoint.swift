//
//  ScaledUnitCirclePoint.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/29/24.
//

import SwiftUI

struct ScaledUnitCirclePoint: View {
  let point: UnitCirclePoint
  let scale: CGFloat
  
  var body: some View {
    let originalWidth: CGFloat = 250
    let originalHeight: CGFloat = 100
    let scaledWidth = originalWidth * scale
    let scaledHeight = originalHeight * scale
    
    Canvas { context, size in
      context.scaleBy(x: scale, y: scale)
      if let pointSymbol = context.resolveSymbol(id: "pointView") {
        context.draw(pointSymbol, in: CGRect(origin: .zero, size: CGSize(width: originalWidth, height: originalHeight)))
      }
    } symbols: {
      PointView(point: point)
        .frame(width: originalWidth, height: originalHeight)
        .tag("pointView")
    }
    .frame(width: scaledWidth, height: scaledHeight)
    .background(Color.white)
    .cornerRadius(5)
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(
          Color(red: 200/255, green: 200/255, blue: 200/255),
          lineWidth: 2
        )
    )
    .background(
      RoundedRectangle(cornerRadius: 5)
        .fill(Color(red: 200/255, green: 200/255, blue: 200/255))
        .offset(x: 2, y: 2)
    )
    
  }
}

struct ScaledUnitCirclePointData: Codable {
  let point: UnitCirclePoint
}
