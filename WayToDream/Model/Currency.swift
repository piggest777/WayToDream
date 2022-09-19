//
//  Currency.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import Foundation

struct Currency: Identifiable, Comparable {
    static func < (lhs: Currency, rhs: Currency) -> Bool {
        lhs.title < rhs.title
    }
    
    var id = UUID()
    var title: String
    var description: String?
}
