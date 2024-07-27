//
//  Points.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/23/24.
//

import SwiftUI

struct UnitCirclePoint {
  let x: Coordinate
  let y: Coordinate
  let angle: Int // Adding angle for reference
  let radian: Radian // Adding radian for reference
  
  struct Coordinate {
    let numerator: Int
    let numeratorSquareRoot: Bool
    let denominator: Int
    let denominatorSquareRoot: Bool
    let isNegative: Bool
    let reducedValue: Int?
  }
  struct Radian {
    let numerator: String
    let denominator: Int
  }
}

let unitCirclePoints: [UnitCirclePoint] = [
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 1),
                  y: .init(numerator: 0, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 0),
                  angle: 0,
                  radian: .init(numerator: "0", denominator: 1)),
  UnitCirclePoint(x: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 30,
                  radian: .init(numerator: "π", denominator: 6)),
  UnitCirclePoint(x: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 45,
                  radian: .init(numerator: "π", denominator: 4)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 60,
                  radian: .init(numerator: "π", denominator: 3)),
  UnitCirclePoint(x: .init(numerator: 0, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 0),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 1),
                  angle: 90,
                  radian: .init(numerator: "π", denominator: 2)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 120,
                  radian: .init(numerator: "2π", denominator: 3)),
  UnitCirclePoint(x: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 135,
                  radian: .init(numerator: "3π", denominator: 4)),
  UnitCirclePoint(x: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  angle: 150,
                  radian: .init(numerator: "5π", denominator: 6)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: true, reducedValue: 1),
                  y: .init(numerator: 0, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 0),
                  angle: 180,
                  radian: .init(numerator: "π", denominator: 1)),
  UnitCirclePoint(x: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 210,
                  radian: .init(numerator: "7π", denominator: 6)),
  UnitCirclePoint(x: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 225,
                  radian: .init(numerator: "5π", denominator: 4)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  y: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 240,
                  radian: .init(numerator: "4π", denominator: 3)),
  UnitCirclePoint(x: .init(numerator: 0, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 0),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: true, reducedValue: 1),
                  angle: 270,
                  radian: .init(numerator: "3π", denominator: 2)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 300,
                  radian: .init(numerator: "5π", denominator: 3)),
  UnitCirclePoint(x: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 2, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 315,
                  radian: .init(numerator: "7π", denominator: 4)),
  UnitCirclePoint(x: .init(numerator: 3, numeratorSquareRoot: true, denominator: 2, denominatorSquareRoot: false, isNegative: false, reducedValue: nil),
                  y: .init(numerator: 1, numeratorSquareRoot: false, denominator: 2, denominatorSquareRoot: false, isNegative: true, reducedValue: nil),
                  angle: 330,
                  radian: .init(numerator: "11π", denominator: 6)),
  UnitCirclePoint(x: .init(numerator: 1, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 1),
                  y: .init(numerator: 0, numeratorSquareRoot: false, denominator: 1, denominatorSquareRoot: false, isNegative: false, reducedValue: 0),
                  angle: 360,
                  radian: .init(numerator: "2π", denominator: 1))
]


struct Points: View {
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        RadianView(numerator: "π", denominator: "6" )
        ForEach(unitCirclePoints, id: \.angle) { point in
          VStack {
            Text("\(point.angle)°")
              .font(.headline)
            PointView(point: point)
          }
        }
      }
      .padding()
    }
  }
}

#Preview {
  Points()
}


struct PointView: View {
  let point: UnitCirclePoint
  
  var body: some View{
    HStack{
      Text("(")
        .defaultPointFormat()
      //add negative sign here if x is negative)
      if(point.x.isNegative){Text("-").defaultPointFormat()}
      if let reducedValue = point.x.reducedValue {
        Text("\(reducedValue)").defaultPointFormat()
      } else {
        CoordinateView(
          numerator: point.x.numerator,
          numeratorSquareRoot: point.x.numeratorSquareRoot,
          denominator: point.x.denominator,
          denominatorSquareRoot: point.x.denominatorSquareRoot
        )
      }
      
      Text(",")
        .defaultPointFormat()
      if(point.y.isNegative){Text("-").defaultPointFormat()}
      if let reducedValue = point.y.reducedValue {
        Text("\(reducedValue)").defaultPointFormat()
      } else {
        CoordinateView(
          numerator: point.y.numerator,
          numeratorSquareRoot: point.y.numeratorSquareRoot,
          denominator: point.y.denominator,
          denominatorSquareRoot: point.y.denominatorSquareRoot
        )
      }
      Text(")")
        .defaultPointFormat()
    }
  }
}

struct CoordinateView: View {
  var numerator: Int
  var numeratorSquareRoot: Bool
  var denominator: Int
  var denominatorSquareRoot: Bool
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      TermView(value: String(numerator), isSquareRoot: numeratorSquareRoot)
      FractionBar()
      TermView(value: String(denominator), isSquareRoot: denominatorSquareRoot)
    }.fixedSize()
  }
}

struct RadianView: View {
  var numerator: String
  var denominator: String
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      TermView(value: numerator)
      FractionBar()
      TermView(value: denominator)
    }.fixedSize()
  }
}

struct TermView: View {
  var value: String
  var isSquareRoot: Bool?
  
  
  var body: some View {
    Text("\(value)")
      .defaultPointFormat()
      .padding(.top, isSquareRoot ?? false ? 4 : 0)
      .padding(.leading, isSquareRoot ?? false ? 30 : 0)
      .padding(.trailing, isSquareRoot ?? false ? 10 : 0)
      .background(
        Group {
          if isSquareRoot ?? false {
            SquareRootOverlay()
          }
        }
      )
  }
  
  
  struct SquareRootOverlay: View {
    var body: some View {
      Canvas { context, size in
        let path = Path { path in
          path.move(to: CGPoint(x: 4, y: size.height - 29))
          path.addLine(to: CGPoint(x: 14, y: size.height - 9))
          path.addLine(to: CGPoint(x: 25, y: 4))
          path.addLine(to: CGPoint(x: size.width - 4, y: 4))
        }
        context.stroke(
          path,
          with: .color(.black),
          style: StrokeStyle(lineWidth: 4.4, lineCap: .round, lineJoin: .round)
        )
      }
    }
  }
}

struct FractionBar: View {
  var body: some View {
    Canvas { context, size in
      let path = Path { path in
        path.move(to: CGPoint(x: 3, y: size.height / 2))
        path.addLine(to: CGPoint(x: size.width - 3, y: size.height / 2))
      }
      context.stroke(
        path,
        with: .color(.black),
        style: StrokeStyle(lineWidth: 4.7, lineCap: .round)
      )
    }
    .frame(height: 4.7)
    
  }
}

extension View {
  func defaultPointFormat() -> some View {
    modifier(DefaultPointFormat())
  }
}

struct DefaultPointFormat: ViewModifier {
  func body(content: Content) -> some View {
    content
      .fontDesign(.rounded)
      .font(.system(size: 36))
      .fontWeight(.bold)
  }
}

