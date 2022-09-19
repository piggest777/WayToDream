//
//  AddCurrencyViewModel.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import Foundation
import SwiftUI
import Alamofire

class AddCurrencyViewModel: ObservableObject {
    
    @Published var currenciesList: [Currency]  = []
    
    
    func getSymbols() {
        AF.request(GET_SYMBOLS_URL).responseDecodable(of: Symbols.self) { response in

                switch response.result {
                case .success(let value):
                    
                    let symbols = value.symbols
                    
                    
                    self.currenciesList = symbols.map({ (key: String, value: Symbol) in
                        Currency(title: key, description: value.symbolDescription)
                    })
                    print(self.currenciesList)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
