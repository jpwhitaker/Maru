//
//  AnswerSelection.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/29/24.
//

import SwiftUI

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

#Preview {
    AnswerSelection()
}
