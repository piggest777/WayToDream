//
//  AddFundsView.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import SwiftUI
import Combine

struct AddFundsView: View {
    
    @Binding var showSheet: Bool
    @Binding var currentBalance: Double
    @Binding var exchangeRate: Double
    @StateObject var balance = Balance()
    @State var inputBalance = ""
    @Binding var currency: String
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                Spacer()
                Text("Current Balance:")
                    .font(.largeTitle)
                Text("\(currentBalance * exchangeRate, specifier: "%.2f") \(currency)")
                    .font(.title2)
                
                Spacer()
                
                HStack {
                    CustomTextField(placeHolder: "Enter Amount", value: $inputBalance, lineColor: .accentColor, width: 2)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 5)
                        .onReceive(Just(inputBalance)) { newValue in
                            var filtered = newValue.filter {
                                "0123456789.".contains($0)}
                            if filtered != newValue {
                                
                                if filtered != newValue {
                                    self.inputBalance = filtered
                                }
                                //                                if let balance: Double = Double(filtered) {
                                //                                    self.inputBalance = String(balance)
                                //                                } else {
                                //                                    print("wrong number format")
                                //                                }
                                
                            }
                            
                        }
                        .keyboardType(.decimalPad)
                    
                    Text(currency)
                        .font(.largeTitle)
                }.padding()
                
                
                
                CustomButton(color: .accentColor, text: "Pay by card") {
                    if let numericBalance = Double(inputBalance)  {
                        
                        
                        
                        currentBalance += numericBalance/exchangeRate
                        
                        UserDefaults.standard.set(currentBalance, forKey: BALANCE)
                        
                        showSheet = false
                        
                    } else {
                        print("wrong number format")
                    }
                }
                
                
            }
            .navigationTitle("Add Funds")
            .environmentObject(balance)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = false
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    
                }
                
                
            }
        }
    }
}

//struct AddFundsView_Previews: PreviewProvider {
//    @State var currBallnce = 0.0
//    static var previews: some View {
//        AddFundsView(showSheet: .constant(true), currentBalance: $currBallnce, currency: "USD")
//    }
//}
