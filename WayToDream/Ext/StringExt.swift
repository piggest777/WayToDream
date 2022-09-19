//
//  StringExt.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-16.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
