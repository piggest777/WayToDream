//
//  AddFundsView.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import SwiftUI
import Combine



//View which imitate wallet top up
struct AddFundsView: View {
    
    @Binding var showSheet: Bool
    @Binding var currentBalance: Double
    @Binding var exchangeRate: Double
    @StateObject var balance = Balance()
    @State var inputBalance = ""
    @Binding var currency: String
    @State var showAlert = false
    
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
                            let filtered = newValue.filter {
                                "0123456789.".contains($0)}
                            if filtered != newValue {
                                
                                if filtered != newValue {
                                    self.inputBalance = filtered
                                }
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
                        
                        showAlert = true
                    }
                }
                
                
            }.alert("wrong number format", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
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
    
}

//struct AddFundsView_Previews: PreviewProvider {
//    @State var currBallnce = 0.0
//    static var previews: some View {
//        AddFundsView(showSheet: .constant(true), currentBalance: $currBallnce, currency: "USD")
//    }
//}
