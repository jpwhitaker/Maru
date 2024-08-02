//
//  CurrentAngle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/28/24.
//

import SwiftUI
import CoreHaptics

struct CurrentAngle: View {
    @EnvironmentObject var draggedObjectPosition: GameState
    @State private var currentAngle: Double?
    @State private var isDragging: Bool = false
    @State private var previousAngle: Double?
    @EnvironmentObject var gameState: GameState
    
    let hapticService = HapticFeedbackService()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Draw the current angle line
              if draggedObjectPosition.isDragging, let angle = currentAngle {
                    Path { path in
                        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        let radius = min(geometry.size.width, geometry.size.height) / 2
                        let endPoint = CGPoint(
                            x: center.x + radius * cos(CGFloat(angle * .pi / 180)),
                            y: center.y - radius * sin(CGFloat(angle * .pi / 180))
                        )
                        path.move(to: center)
                        path.addLine(to: endPoint)
                    }
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 5.0, lineCap: .round))
                    
                    let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    let radius = min(geometry.size.width, geometry.size.height) / 2
                    let endPoint = CGPoint(
                        x: center.x + radius * cos(CGFloat(angle * .pi / 180)),
                        y: center.y - radius * sin(CGFloat(angle * .pi / 180))
                    )
                    
                    Circle()
                    .fill(Color(.white))
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .position(endPoint)
                }
            }

            .coordinateSpace(name: "custom")
            .onChange(of: draggedObjectPosition.position) { _, newPosition in
                let viewOrigin = geometry.frame(in: .named("custom")).origin
                let adjustedDragPosition = CGPoint(x: newPosition.x - viewOrigin.x, y: newPosition.y - viewOrigin.y)
                updateAngle(dragLocation: adjustedDragPosition, in: geometry.size)
            }
        }
    }
    
  private func updateAngle(dragLocation: CGPoint, in size: CGSize) {
      let center = CGPoint(x: size.width / 2, y: size.height / 2)
      let dx = dragLocation.x - center.x
      let dy = center.y - dragLocation.y  // Invert y-axis
      
      var dragAngle = atan2(dy, dx)
      
      // Normalize the angle to be between 0 and 2π
      if dragAngle < 0 {
          dragAngle += 2 * .pi
      }
      
      // Convert radians to degrees
      let dragAngleDegrees = dragAngle * 180 / .pi
      
      // Define all angles at 30-degree and 45-degree intervals
      let predefinedAngles: [Double] = Array(stride(from: 0, to: 360, by: 30)) +
          Array(stride(from: 0, to: 360, by: 45)).filter { $0.truncatingRemainder(dividingBy: 30) != 0 }
      
    // Find the nearest predefined angle, this normalizes the wrapping from 360 to 0
    let newAngle = predefinedAngles.min(by: { a, b in
      let diffA = min(abs(a - dragAngleDegrees), abs(a - dragAngleDegrees + 360))
      let diffB = min(abs(b - dragAngleDegrees), abs(b - dragAngleDegrees + 360))
        return diffA < diffB
    })
      
      // Check if the angle has changed to a new predefined value
      if newAngle != previousAngle {
          // Set the angle to 0 if it's 360
          currentAngle = newAngle == 360 ? 0 : newAngle
          previousAngle = currentAngle
          gameState.currentHoveredAngle = currentAngle ?? 0
          hapticService.playHapticFeedback()
      }
  }
}

#Preview {
    QuizView()
        .environmentObject(GameState())
}
