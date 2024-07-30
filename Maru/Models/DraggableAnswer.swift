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
