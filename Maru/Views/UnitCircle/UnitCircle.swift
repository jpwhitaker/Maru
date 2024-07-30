//
//  UnitCircle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI

struct UnitCircle: View {
      var showCurrentAngle: Bool = false
      var showUnitCirclePoints: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                Angles()
                CircleLine()
                DotView()
                if showCurrentAngle {
                    CurrentAngle()
                }
            }.padding(35)
            
            if showUnitCirclePoints {
                UnitCirclePoints()
            }
        }
    }
}

#Preview {
    UnitCircle()
        .environmentObject(DraggedObjectPosition())
}
