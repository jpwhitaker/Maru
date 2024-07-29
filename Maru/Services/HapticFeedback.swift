//
//  HapticFeedback.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/28/24.
//

import UIKit
import CoreHaptics

class HapticFeedbackService {
    private var hapticEngine: CHHapticEngine?
    private let hapticGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let selectionGenerator = UISelectionFeedbackGenerator()


    init() {
        prepareHaptics()
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func playHapticFeedback() {
        hapticGenerator.impactOccurred()
    }
  
  func playSelectionChanged() {
      selectionGenerator.selectionChanged()
  }
}
