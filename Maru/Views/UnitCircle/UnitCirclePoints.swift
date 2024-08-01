//
//  UnitCircle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI

struct UnitCirclePoints: View {
  @EnvironmentObject var gameState: GameState
  var showPointsAtStart: Bool = false
  let labelScale: CGFloat
  init(labelScale: CGFloat = 0.23) {
    self.labelScale = labelScale
  }
  
  var body: some View {
    GeometryReader { geometry in
      let diameter = min(geometry.size.width, geometry.size.height)
      let radius = diameter / 2
      
      Canvas { context, size in
        let canvasBounds = CGRect(origin: .zero, size: size)
        
        for point in unitCirclePoints {
          guard let symbol = context.resolveSymbol(id: point.angle) else { continue }
          
          let x = radius * CGFloat(cos(Double(-point.angle) * .pi / 180)) + radius
          let y = radius * CGFloat(sin(Double(-point.angle) * .pi / 180)) + radius
          
          let symbolSize = CGSize(width: symbol.size.width * labelScale,
                                  height: symbol.size.height * labelScale)
          let proposedFrame = CGRect(x: x - symbolSize.width/2,
                                     y: y - symbolSize.height/2,
                                     width: symbolSize.width,
                                     height: symbolSize.height)
          
          if canvasBounds.contains(proposedFrame) {
            context.draw(symbol, at: CGPoint(x: x, y: y), anchor: .center)
          } else {
            var dx: CGFloat = 0
            var dy: CGFloat = 0
            
            if proposedFrame.minX < canvasBounds.minX {
              dx = canvasBounds.minX - proposedFrame.minX
            } else if proposedFrame.maxX > canvasBounds.maxX {
              dx = canvasBounds.maxX - proposedFrame.maxX
            }
            
            if proposedFrame.minY < canvasBounds.minY {
              dy = canvasBounds.minY - proposedFrame.minY
            } else if proposedFrame.maxY > canvasBounds.maxY {
              dy = canvasBounds.maxY - proposedFrame.maxY
            }
            
            context.draw(symbol, at: CGPoint(x: x + dx, y: y + dy), anchor: .center)
          }
        }
      } symbols: {
        ForEach(unitCirclePoints, id: \.angle) { point in
          PointView(point: point)
            .scaleEffect(labelScale)
            .opacity(gameState.correctAnswers.contains(round(point.angle * 100) / 100) ? 1.0 : 0.2)

            .tag(point.angle)
        }
      }
      .frame(width: diameter, height: diameter)
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
  }
}
#Preview {
  UnitCirclePoints()
    .environmentObject(GameState())
}
