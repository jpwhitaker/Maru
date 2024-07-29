//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizView: View {
  @State private var randomPoint: UnitCirclePoint
  
  init() {
    // Initialize with a random point
    _randomPoint = State(initialValue: unitCirclePoints.randomElement()!)
  }
  
  var body: some View {
    VStack{
      Spacer()
//      unitCirclePoints
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
  @State private var draggableAnswers: [DraggableAnswer] = []
  @State private var draggedAnswer: DraggableAnswer?
  @State private var dragOffset: CGSize = .zero
  
  var body: some View {
    Grid(horizontalSpacing: 5, verticalSpacing: 5) {
      ForEach(0..<4, id: \.self) { row in
        GridRow {
          ForEach(0..<4, id: \.self) { column in
            let index = row * 4 + column
            if index < draggableAnswers.count {
              ScaledUnitCirclePoint(point: draggableAnswers[index].ScaledPoint.point)
                .id(draggableAnswers[index].id)
                .offset(draggedAnswer?.id == draggableAnswers[index].id ? dragOffset : .zero)
                .gesture(
                  DragGesture(minimumDistance: 0.1)
                    .onChanged { gesture in
                      if draggedAnswer == nil {
                        draggedAnswer = draggableAnswers[index]
                      }
                      dragOffset = gesture.translation
                    }
                    .onEnded { _ in
                      draggedAnswer = nil
                      dragOffset = .zero
                    }
                )
            } else {
              Color.clear
            }
          }
        }
      }
    }
    .padding()
    .onAppear {
      draggableAnswers = unitCirclePoints.shuffled().map { point in
        DraggableAnswer(
          id: UUID(),
          ScaledPoint: ScaledUnitCirclePointData(point: point)
        )
      }
    }
  }
}

struct ScaledUnitCirclePointData: Codable {
    let point: UnitCirclePoint // Assuming UnitCirclePoint is also Codable
    // Add any other properties you need to encode/decode
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
        .frame(width: originalWidth, height: originalHeight)
        .tag("pointView")
        
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(16)
    }
    .frame(width: scaledWidth, height: scaledHeight)
  }
}

struct DraggableAnswer: Codable, Transferable {
  let id: UUID
  let ScaledPoint: ScaledUnitCirclePointData
  
  static var transferRepresentation: some TransferRepresentation{
    CodableRepresentation(contentType: .draggableAnswer)
  }
}

extension UTType {
  static let draggableAnswer = UTType(exportedAs: "com.jpw.Maru.draggableAnswer")
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



