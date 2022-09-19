//
//  Ticker.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import Foundation


struct Ticker: Codable {
    
    let symbol: String
    let baseAsset: String
    let quoteAsset: QuoteAsset
    let openPrice: String
    let lowPrice: String
    let highPrice: String
    let lastPrice: String
    let volume: String
    let bidPrice: String
    let askPrice: String
    let at: Int
    
    

    
    
    
    
    
//    "symbol": "btcinr",
//      "baseAsset": "btc",
//      "quoteAsset": "inr",
//      "openPrice": "1691424",
//      "lowPrice": "1661126.0",
//      "highPrice": "1732000.0",
//      "lastPrice": "1693640.0",
//      "volume": "6.32214",
//      "bidPrice": "1676002.0",
//      "askPrice": "1693600.0",
//      "at": 1663272388000
}


enum QuoteAsset: String, Codable{
    case BTC = "btc"
    case INR = "inr"
    case USDT = "usdt"
    case WRX = "wrx"
}

