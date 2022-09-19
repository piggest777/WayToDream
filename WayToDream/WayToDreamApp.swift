//
//  WayToDreamApp.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import SwiftUI

@main
struct WayToDreamApp: App {
    
    init() {
        if UserDefaults.standard.array(forKey: CURRENCIES) == nil {
            
            UserDefaults.standard.set(["USD", "SEK"], forKey: CURRENCIES)
            UserDefaults.standard.set("USD", forKey: CURRENT_CURRENCY)
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
