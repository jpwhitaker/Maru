//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI
import UniformTypeIdentifiers

class GameState: ObservableObject {
  @Published var position: CGPoint = .zero
  @Published var isDragging: Bool = false
  @Published var selectedAnswerAngle: Int = 0
  @Published var currentHoveredAngle: Int = 0
  
  
}

struct QuizView: View {
  @StateObject private var draggedObjectPosition = GameState()
  
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        UnitCircle(showCurrentAngle: true, showUnitCirclePoints: true)
          .padding(10)
        
      }
      .environmentObject(draggedObjectPosition)
      Spacer()
      AnswerSelection()
        .environmentObject(draggedObjectPosition)
    }
  }
}

#Preview {
  QuizView()
}
