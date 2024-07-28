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
        let point = unitCirclePoints[0]
        let scale: CGFloat = 0.4
        let originalWidth: CGFloat = 120
        let originalHeight: CGFloat = 45
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

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for index in stride(from: 0, to: count, by: size) {
            let chunk = Array(self[index..<Swift.min(index + size, count)])
            chunks.append(chunk)
        }
        return chunks
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



