//
//  ExchangeView.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-15.
//

import SwiftUI

struct ExchangeView: View {
    
    @State var currency = "USD"
    
    @State var searchText = ""
    @State var focused: Bool = false
    @State var showCurrencySheet: Bool = false
    @State var showAddFundsSheet: Bool = false
    @EnvironmentObject var balance: Balance
    var placeholder = "Select Currency"
    @State var value = ""
    @State var textBalance  = 0.0
    
    
    
    @ObservedObject var vm = ExchangeViewModel()
    
    
    var searchResults: [Ticker] {
        if searchText.isEmpty {
            return vm.tickers
        } else {
            return vm.tickers.filter { $0.baseAsset.contains(searchText.lowercased()) }
        }
    }

    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Rectangle()
                    .fill(Color("Background"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Group {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color("lightYellow"))
                                .shadow(radius: 10)
                            
                            VStack {
                                Text("My Wallet")
                                    .font(.largeTitle)
                                    .padding(.top, 10)
                                
                                
                                
                                HStack {
                                    Spacer()
                                    Text("\(textBalance * vm.exchangeRate, specifier: "%.2f")")
                                        .fontWeight(.heavy)
                                        .font(.largeTitle)
                                        .onAppear(){
                                            textBalance = balance.balance
                                        }
                                    
                                    Menu {
                                        ForEach(balance.currenciesArray, id: \.id){ currency in
                                            Button("\(currency.title)") {
                                                self.currency = currency.title
                                                UserDefaults.standard.set(currency.title, forKey: CURRENT_CURRENCY)
                                                vm.getRate(from: "USD", to: self.currency)
                                            }
                                            
                                            
                                        }
                                        
                                        Button {
                                            showCurrencySheet = true
                                        } label: {
                                            Text("Add more")
                                        }
                                        
                                    } label: {
                                        
                                        VStack(spacing: 5){
                                            HStack{
                                                Text(currency.isEmpty ? placeholder : currency)
                                                    .foregroundColor(currency.isEmpty ? .gray : .black)
                                                
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(.accentColor)
                                                    .font(Font.system(size: 20, weight: .bold))
                                            }
                                            //                                    .padding(.horizontal)
                                            Rectangle()
                                                .fill(Color.accentColor)
                                                .frame(maxWidth: 75, maxHeight: 2)
                                        }
                                        
                                    }
                                    Spacer()
                                    
                                }
                                
                                CustomButton(color: .accentColor, text: "Add funds") {
                                    showAddFundsSheet = true
                                }
                                
                            }
                            
                            
                        }.frame( height: 225, alignment: .top)
                            .padding(.horizontal, 10)
                    }
                        
                        Spacer()
                        Text("Crypto rates")
                            .font(.system(size: 30, weight: .heavy, design: .default))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)

                    ZStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .visibility(vm.visibilityProgressView)
                        
                        ScrollView {
                                ForEach(searchResults, id: \.baseAsset) { ticker in
                                    ListRow(userAmount: $textBalance, currency: $currency, exchangeRate: $vm.exchangeRate ,ticker: ticker)
                                }
                            }
                            .searchable(text: $searchText)
                            .onAppear {
                                vm.getTickers(quoteAsset: .USDT)
                                currency = balance.currentCurrency
                                
                                vm.getRate(from: "USD", to: currency)
                        }
                    }
                    
                }
            }
        }.sheet(isPresented: $showCurrencySheet) {
            AddCurrencyView(showSheet: $showCurrencySheet)
            
        }
        .sheet(isPresented: $showAddFundsSheet) {
            AddFundsView(showSheet: $showAddFundsSheet, currentBalance: $textBalance, exchangeRate: $vm.exchangeRate, currency: $currency)
        }
        
        
    }
       
        
}

struct ExchangeView_Previews: PreviewProvider {
    static let balance  = Balance()
    static var previews: some View {
        ExchangeView()
            .environmentObject(balance)
    }
}

struct ListRow: View {
    
    @Binding var userAmount: Double
    @Binding var currency: String
    @Binding var exchangeRate: Double
    let ticker: Ticker
    var differences: Double  {
        (ticker.lastPrice.toDouble()! - ticker.openPrice.toDouble()!)/ticker.openPrice.toDouble()! * 100
    }
    
    var negative: Bool {
        if( differences < 0 ) {
            return true
        }
        else {
            return false
        }
    }

       
    
    var body: some View {
        
        
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color("lightYellow"))
                    .shadow(radius: 5)
                    .addBorder(Color.gray, width: 2, cornerRadius: 15)
                
                HStack{
                    VStack {
                        HStack {
                            Text("\(ticker.baseAsset.uppercased())")
                                .font(.title)
                            Text("/ \(currency)")
                                .font(.headline)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                       
                            HStack{
                                Text("Buy up to:")
                                    .font(.callout)
                                Text("\(userAmount/ticker.lastPrice.toDouble()!, specifier: "%.4f")")
                                    .font(.callout)
                            }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: negative ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill" )
                                .foregroundColor( negative ? .red : .green)
                            Text("\(differences, specifier: "%.2f") %")
                                .foregroundColor(negative ? .red : .green)
                        }

                        Text("Price: \((ticker.lastPrice.toDouble()! * exchangeRate.round(to: 2)).removeZerosFromEnd())")
//                        HStack {
//                            Text("Price: ")
//                                .font(.callout)
//                            Text("\((ticker.lastPrice.toDouble()! * exchangeRate.round(to: 2)).removeZerosFromEnd()) \(currency)")
//                                .font(.callout)
//                                .frame( alignment: .leading)
//                        }
                        

                    }
                }
                .padding()
            }
            .padding(.horizontal, 10)
        
    }
}
