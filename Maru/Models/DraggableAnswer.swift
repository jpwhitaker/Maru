//
//  DraggableAnswer.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/29/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct DraggableAnswer: Codable, Transferable {
    let id: UUID
    let ScaledPoint: ScaledUnitCirclePointData
  
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggableAnswer)
    }
}

extension UTType {
  static let draggableAnswer = UTType(exportedAs: "com.jpw.Maru.draggableAnswer")
}

extension DraggableAnswer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: DraggableAnswer, rhs: DraggableAnswer) -> Bool {
        return lhs.id == rhs.id
    }
}
