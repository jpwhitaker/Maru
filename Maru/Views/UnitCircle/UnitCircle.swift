//
//  UnitCircle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI
import Zoomable

struct UnitCircle: View {
  var body: some View {
    UnitCircleOuterFrame()
      .overlay(Color.clear
        .contentShape(Rectangle())
      )
      .zoomable()
  }
}

#Preview {
  UnitCircle()
}
