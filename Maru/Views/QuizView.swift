//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI
import UniformTypeIdentifiers



struct QuizView: View {
  @StateObject private var gameState = GameState()
  
  var body: some View {
    VStack {
      Spacer()
      ZStack {
        UnitCircle(showCurrentAngle: true, showUnitCirclePoints: true)
          .environmentObject(gameState)
          .padding(10)
        
      }
      
      Spacer()
      AnswerSelection()
        .environmentObject(gameState)
    }
  }
}

#Preview {
  QuizView()
}
