//
//  Ticker.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import Foundation



//Model for Ticker to get objects from WAZIRIX
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
    
}


enum QuoteAsset: String, Codable{
    case BTC = "btc"
    case INR = "inr"
    case USDT = "usdt"
    case WRX = "wrx"
}

