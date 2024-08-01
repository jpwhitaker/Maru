//
//  ContentView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI

class GameState: ObservableObject {
  @Published var position: CGPoint = .zero
  @Published var isDragging: Bool = false
  @Published var selectedAnswerAngle: Double = 0
  @Published var currentHoveredAngle: Double = 0
  @Published var correctAnswers: [Double] = []
  
  
}

struct ContentView: View {

  @StateObject private var gameState = GameState()
  
  
  var body: some View {
    
    GeometryReader { geometry in
      NavigationStack {
        VStack{
          Spacer()
          UnitCircle()
            .padding(10)
            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
            .environmentObject(gameState)
            
          Spacer()
          VStack(spacing: 10){
            Spacer()
//            NavigationLink("Learn to Draw the Unit Circle") {
//              TutorialView()
//            }
            
            NavigationLink("Quiz Yourself") {
              QuizView()
            }
//            NavigationLink("View Unit Circle") {
//              UnitCircleView()
//            }
            Spacer()
          }
        }
      }
    }
  }
}


struct TutorialView: View {
  var body: some View {
    Text("tutorial view")
      .navigationTitle("tutorial")
  }
}

struct UnitCircleView: View {
  var body: some View {
    Text("unit circle view")
      .navigationTitle("View the Unit Circle")
  }
}

struct UnitCircleQuizView: View {
  var body: some View {
    Text("Quiz View")
      .navigationTitle("Quiz Yourself")
  }
}

#Preview {
  ContentView()
    .environmentObject(GameState())
}
