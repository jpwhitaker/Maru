//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct QuizView: View {
  
  var body: some View {
    VStack{
      Spacer()

      UnitCircle()
        .padding(10)
      Spacer()
      AnswerSelection()

    }
  }
}
struct AnswerSelection: View {
    @State private var allAnswers: [DraggableAnswer] = []
    @State private var displayedAnswers: [DraggableAnswer?] = [nil, nil, nil, nil]
    @State private var draggedAnswer: DraggableAnswer?
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                GridRow {
                    ForEach(0..<2) { column in
                        answerView(for: column)
                    }
                }
                GridRow {
                    ForEach(2..<4) { column in
                        answerView(for: column)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            initializeAnswers()
        }
    }
    
    private func answerView(for index: Int) -> some View {
        Group {
            if let answer = displayedAnswers[index] {
                ScaledUnitCirclePoint(point: answer.ScaledPoint.point)
                    .id(answer.id)
                    .offset(draggedAnswer?.id == answer.id ? dragOffset : .zero)
                    .gesture(
                        DragGesture(minimumDistance: 0.1)
                            .onChanged { gesture in
                                if draggedAnswer == nil {
                                    draggedAnswer = answer
                                }
                                dragOffset = gesture.translation
                            }
                            .onEnded { _ in
                                if let draggedAnswer = draggedAnswer {
                                    removeAnswer(draggedAnswer, at: index)
                                }
                                draggedAnswer = nil
                                dragOffset = .zero
                            }
                    )
            } else {
                Color.clear
            }
        }
    }
    
    private func initializeAnswers() {
        allAnswers = unitCirclePoints.shuffled().map { point in
            DraggableAnswer(
                id: UUID(),
                ScaledPoint: ScaledUnitCirclePointData(point: point)
            )
        }
        refillDisplayedAnswers()
    }
    
    private func removeAnswer(_ answer: DraggableAnswer, at index: Int) {
        displayedAnswers[index] = nil
        allAnswers.removeAll { $0.id == answer.id }
        refillDisplayedAnswers()
    }
    
    private func refillDisplayedAnswers() {
        for i in 0..<4 {
            if displayedAnswers[i] == nil && !allAnswers.isEmpty {
                displayedAnswers[i] = allAnswers.removeFirst()
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



