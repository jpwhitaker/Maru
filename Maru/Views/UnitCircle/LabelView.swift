//
//  LabelView.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/4/24.
//

import SwiftUI
import SwiftMath

struct MathUILabel: UIViewRepresentable {
  var latex: String
  
  func makeUIView(context: Context) -> MTMathUILabel {
    let label = MTMathUILabel()
    label.latex = latex
    label.layer.borderColor = UIColor.red.cgColor
    label.layer.borderWidth = 2.0
    return label
  }
  
  func updateUIView(_ uiView: MTMathUILabel, context: Context) {
    uiView.latex = latex
  }
}

struct MathView: UIViewRepresentable {
  var equation: String
  var fontSize: CGFloat
  
  func makeUIView(context: Context) -> MTMathUILabel {
    let view = MTMathUILabel()
//    view.layer.backgroundColor = UIColor.yellow.cgColor
    //for debug
//          view.layer.borderColor = UIColor.red.cgColor
//          view.layer.borderWidth = 1.0
    return view
  }
  
  func updateUIView(_ uiView: MTMathUILabel, context: Context) {
    uiView.latex = equation
    uiView.fontSize = fontSize
    uiView.textColor = UIColor.label

    uiView.font = MTFontManager().kpMathLightFont(withSize: fontSize)
    uiView.font = MTFontManager().kpMathSansFont(withSize: fontSize)
    uiView.font = MTFontManager().xitsFont(withSize: fontSize)
//    uiView.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: .systemFontSize)!
    uiView.textAlignment = .center
    uiView.labelMode = .text
  }
}

struct LabelView: View {
  var equation: String
  var fontSize: Float = 12
  var body: some View {
    MathView(equation: equation, fontSize: CGFloat(fontSize))
      .frame(width: 30, height:30)
  }
}

#Preview {
    LabelView(equation: "$\\left(\\frac{\\sqrt{3}}{2}, \\frac{1}{2}\\right)$")
}
