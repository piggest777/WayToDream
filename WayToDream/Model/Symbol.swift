//
//  Symbol.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import Foundation


struct Symbols: Codable {
    let success: Bool
    let symbols: [String: Symbol]
}

// MARK: - Symbol
struct Symbol: Codable {
    let symbolDescription, code: String

    enum CodingKeys: String, CodingKey {
        case symbolDescription = "description"
        case code
    }
}
