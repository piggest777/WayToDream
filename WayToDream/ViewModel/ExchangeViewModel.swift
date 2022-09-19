//
//  ExchangeViewModel.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import Foundation
import Alamofire

class ExchangeViewModel: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var exchangeRate: Double = 1
    @Published var visibilityProgressView: ViewVisibility = .invisible
    
    func getTickers(quoteAsset: QuoteAsset) {
        visibilityProgressView = .visible
        
        AF.request(WAZIRIX_24H_TICKER_PRICE).responseDecodable(of: [Ticker].self) { responce in
            
            switch responce.result {
            case .success(let value):
                
                let filteredAssets =  value.filter {
                    $0.quoteAsset == quoteAsset
                }
                self.tickers = filteredAssets
                self.visibilityProgressView = .invisible
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getRate(from: String, to: String) {
        
        AF.request("\(EXCHANGE_RATE_BASE_URL)from=\(from)&to=\(to)").responseDecodable(of: CurrencyRate.self) {  response in
                
                switch response.result {
                case .success(let value):
                    
                    self.exchangeRate = value.result
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
