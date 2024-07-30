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
      ZStack{
        UnitCircle()
          .padding(10)
        CurrentAngle()
      }
      Spacer()
      AnswerSelection()

    }
  }
}

#Preview {
  QuizView()
}



