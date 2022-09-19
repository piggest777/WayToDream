//
//  Balance.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import Foundation
import SwiftUI


class Balance: ObservableObject {
    @Published var balance: Double = 0.0
    @Published var currenciesArray: [Currency] = []
    @Published var currentCurrency = ""
    
    func getBalance() {
        
        //request API to get balance but for purpose of this app just get a double value from userDefaults
        balance = UserDefaults.standard.double(forKey: BALANCE)
    }
    
    func changeBalance(added: Double) {
        balance += added
    }
}
