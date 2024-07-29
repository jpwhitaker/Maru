//
//  UnitCircle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI

struct UnitCircle: View {
  
  
  var body: some View {
    ZStack{
      Group{
        Angles()
        CircleLine()
        DotView()
        
      }.padding(35)
      UnitCirclePoints()
      CurrentAngle()
    }
  }
}
#Preview {
  UnitCircle()
}
