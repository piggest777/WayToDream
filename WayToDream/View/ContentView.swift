//
//  ContentView.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var balance = Balance()
    
    var body: some View {
        ExchangeView()
            .background(Color("lightDark"))
            .environmentObject(balance)
            .onAppear{
                balance.getBalance()
                
                balance.currenciesArray = UserDefaults.standard.array(forKey: CURRENCIES)!.map{Currency(title: $0 as! String)}
                
                balance.currentCurrency = UserDefaults.standard.string(forKey: CURRENT_CURRENCY)!
            }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
