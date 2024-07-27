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
      
    }
  }
}

#Preview {
  QuizView()
}
