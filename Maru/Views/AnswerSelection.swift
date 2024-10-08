//
//  AnswerSelection.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/29/24.
//

import SwiftUI

struct ViewPositionKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}

struct AnswerSelection: View {
  @State private var allAnswers: [DraggableAnswer] = []
  @State private var displayedAnswers: [DraggableAnswer?] = [nil, nil, nil, nil]
  @State private var draggedAnswer: DraggableAnswer?
  @State private var dragOffset: CGSize = .zero
  @State private var viewPositions: [CGRect] = [.zero, .zero, .zero, .zero]
  @EnvironmentObject var gameState: GameState
  @StateObject private var audioPlayer = AudioPlayer.shared
  
  var body: some View {
    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
      ForEach(0..<displayedAnswers.count, id: \.self) { index in
        if displayedAnswers[index] != nil {
          RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .stroke(
              Color(red: 200/255, green: 200/255, blue: 200/255),
              lineWidth: 4
            )
            .frame(height: 100)
            .overlay(){
              answerView(for: index)
                .onPreferenceChange(ViewPositionKey.self) { position in
                  viewPositions[index] = position
                }
            }
            .background(
              RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 200/255, green: 200/255, blue: 200/255))
                .offset(x: 5, y: 5)
            )
        } else {
          Color.clear
            .frame(height: 100)
        }
      }
    }
    .padding(20)
    .onAppear {
      initializeAnswers()
    }
  }
  
  private func answerView(for index: Int) -> some View {
    Group {
      if let answer = displayedAnswers[index] {
        ScaledUnitCirclePoint(
            point: answer.ScaledPoint.point,
            scale: draggedAnswer?.id == answer.id ? 0.34 : 0.5,
            isDragging: draggedAnswer?.id == answer.id
        )
          .id(answer.id)
          .offset(draggedAnswer?.id == answer.id ? dragOffset : .zero)
          .background(
            GeometryReader { geometry in
              Color.clear
                .preference(key: ViewPositionKey.self, value: geometry.frame(in: .global))
            }
          )
          .gesture(
            DragGesture(minimumDistance: 0.1)
              .onChanged { gesture in
                if draggedAnswer == nil {
                  draggedAnswer = answer
                }
                gameState.isDragging = true
                
                //Store the selected answer's corresponding angle value
                gameState.selectedAnswerAngle = answer.ScaledPoint.point.angle
                
                //adjust the offset a bit so you can see the answer.
                dragOffset = CGSize(width: gesture.translation.width, height: gesture.translation.height - 60)
                
                
                let frame = viewPositions[index]
                let centerPoint = CGPoint(
                  x: frame.origin.x + frame.size.width / 2,
                  y: frame.origin.y + frame.size.height / 2
                )
                let currentPosition = CGPoint(
                  x: centerPoint.x + gesture.translation.width,
                  y: centerPoint.y + gesture.translation.height
                )
                
                gameState.position = currentPosition
              }
              .onEnded { _ in
                if let draggedAnswer = draggedAnswer {
                  if gameState.selectedAnswerAngle == gameState.currentHoveredAngle {
                    gameState.correctAnswers.append(gameState.selectedAnswerAngle)
                    removeAnswer(draggedAnswer, at: index)
                    Task {
                      await audioPlayer.playSound(named: "correct")
                    }
                  } else {
                    Task {
                      await audioPlayer.playSound(named: "error")
                    }
                  }
                }
                gameState.isDragging = false
                draggedAnswer = nil
                dragOffset = .zero
                gameState.position = .zero
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
    .environmentObject(GameState())
}
