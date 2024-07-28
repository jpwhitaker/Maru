//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI

struct QuizView: View {
  @State private var randomPoint: UnitCirclePoint
  
  init() {
    // Initialize with a random point
    _randomPoint = State(initialValue: unitCirclePoints.randomElement()!)
  }
  
  var body: some View {
    VStack{
      Spacer()
      //unitCirclePoints
      PointView(point: randomPoint)
        .onTapGesture {
          randomPoint = unitCirclePoints.randomElement()!
        }
        .defaultPointFormat()
      UnitCircle()
        .padding(10)
      Spacer()
      AnswerSelection()
      
      
      
      
    }
  }
}
struct AnswerSelection: View {
  var body: some View {
    Grid(horizontalSpacing: 5, verticalSpacing: 5) {
      ForEach(0..<4, id: \.self) { row in
        GridRow {
          ForEach(0..<4, id: \.self) { column in
            let index = row * 4 + column
            if index < unitCirclePoints.count {
              ScaledUnitCirclePoint(point: unitCirclePoints[index])
            } else {
              Color.clear
            }
          }
        }
      }
    }
    .padding()
  }
}

struct ScaledUnitCirclePoint: View {
  let point: UnitCirclePoint
  var body: some View {
    
    let scale: CGFloat = 0.34
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
        .border(.green)
        .frame(width: originalWidth, height: originalHeight)
        .tag("pointView")
    }
    .frame(width: scaledWidth, height: scaledHeight)
    .border(.red)
  }
}


struct TinyButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .controlSize(.mini)
      .padding(5)
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(5)
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}


#Preview {
  QuizView()
}



