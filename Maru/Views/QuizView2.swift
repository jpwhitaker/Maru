//
//  QuizView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/26/24.
//

import SwiftUI

struct QuizView2: View {
  
  
  var body: some View {
    VStack(spacing: 0){
      Color.clear
      Rectangle()
        .fill(Color.blue)
        .aspectRatio(1, contentMode: .fill)
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.all)
      Rectangle().stroke(.red, lineWidth: 1)
        .overlay {
          VStack {
            Button("Button 1") {}
            Button("Button 2") {}
          }
        }
    }
    .ignoresSafeArea(.all)
  }
}

#Preview {
    QuizView2()
}

