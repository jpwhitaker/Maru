//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI
import UniformTypeIdentifiers

// Move this class outside of QuizView
class DraggedObjectPosition: ObservableObject {
  @Published var position: CGPoint = .zero
}

struct QuizView: View {
  @StateObject private var draggedObjectPosition = DraggedObjectPosition()
  
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
