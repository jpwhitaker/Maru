//
//  DotView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 6/27/24.
//

import SwiftUI

struct Point: Identifiable {
    let id = UUID()
    let angle: Double
}

struct DotView: View {
    @State private var animateDots = false
    let points: [Point] = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330].map { Point(angle: $0) }

    var body: some View {
        GeometryReader { geometry in
            ForEach(points) { point in
                unitCirclePoint(
                    from: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
                    radius: min(geometry.size.width, geometry.size.height) / 2,
                    angle: point.angle,
                    animate: animateDots
                )
                .animation(Animation.interpolatingSpring(stiffness: 70, damping: 6).delay(Double(points.firstIndex(where: { $0.id == point.id }) ?? 0) * (2.0 / Double(points.count + 1))), value: animateDots)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animateDots = true
            }
        }
    }

    func unitCirclePoint(from startPoint: CGPoint, radius: CGFloat, angle: Double, animate: Bool) -> some View {
        let endPoint = CGPoint(
            x: startPoint.x + radius * CGFloat(cos(-angle * .pi / 180)),
            y: startPoint.y + radius * CGFloat(sin(-angle * .pi / 180))
        )
        
        return Circle()
            .fill(Color.red)
            .frame(width: 10, height: 10)
            .scaleEffect(animate ? 1.0 : 0.0)
            .position(endPoint)
    }
}

#Preview {
    DotView()
}

