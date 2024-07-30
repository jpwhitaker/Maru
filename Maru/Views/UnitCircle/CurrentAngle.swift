//
//  CurrentAngle.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/28/24.
//

import SwiftUI
import CoreHaptics

struct CurrentAngle: View {
  @State private var currentAngle: Double?
  @State private var isDragging: Bool = false
  @State private var previousAngle: Double?
  
  
  let hapticService = HapticFeedbackService()
  
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Draw the current angle line
        if let angle = currentAngle {
          Path { path in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2 - 35
            let endPoint = CGPoint(
              x: center.x + radius * cos(CGFloat(angle * .pi / 180)),
              y: center.y - radius * sin(CGFloat(angle * .pi / 180))
            )
            path.move(to: center)
            path.addLine(to: endPoint)
          }
          .stroke(Color.black, style: StrokeStyle(lineWidth: 5.0, lineCap: .round))
          
          
          let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
          let radius = min(geometry.size.width, geometry.size.height) / 2 - 35
          let endPoint = CGPoint(
            x: center.x + radius * cos(CGFloat(angle * .pi / 180)),
            y: center.y - radius * sin(CGFloat(angle * .pi / 180))
          )
          
          Circle()
            .fill(Color.white)
            .frame(width: 20, height: 20)
            .overlay(
              Circle()
                .stroke(Color.black, lineWidth: 4)
            )
            .position(endPoint)
        }
        
        // Invisible circle for drag gesture
        Circle()
          .fill(Color.clear)
          .contentShape(Circle())
          .gesture(
            DragGesture(minimumDistance: 0)
              .onChanged { value in
                isDragging = true
                updateAngle(dragLocation: value.location, in: geometry.size)
              }
              .onEnded { _ in
                isDragging = false
              }
          )
      }
      .border(.green)
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
    let predefinedAngles: [Double] = Array(stride(from: 0, through: 360, by: 30)) +
    Array(stride(from: 0, through: 360, by: 45)).filter { $0.truncatingRemainder(dividingBy: 30) != 0 }
    
    // Find the nearest predefined angle
    let newAngle = predefinedAngles.min(by: { abs($0 - dragAngleDegrees) < abs($1 - dragAngleDegrees) })
    
    // Check if the angle has changed to a new predefined value
    if newAngle != previousAngle {
      currentAngle = newAngle
      previousAngle = newAngle
      hapticService.playHapticFeedback()
    }
  }
}
  
  #Preview {
    CurrentAngle()
  }
