//
//  AddCurrencyView.swift
//  WayToDream
//
//  Created by Denis Rakitin on 2022-09-17.
//

import SwiftUI

//View for adding additional currencies in wallet
struct AddCurrencyView: View {
    
    @Binding var showSheet: Bool
    @Binding var currencies: [Currency]
    @ObservedObject var vm = AddCurrencyViewModel()
    @StateObject var balance = Balance()
    
    var body: some View {

        NavigationView{
            List(vm.currenciesList.sorted(), id: \.title) { symbol in
                HStack {
                    Text("\(symbol.title)")
                    Text(symbol.description ?? "")
                        .frame(maxWidth: .infinity,alignment: .trailing)
                }.onTapGesture {
                    var currenciesArray  = UserDefaults.standard.array(forKey: CURRENCIES)
                    currenciesArray!.append(symbol.title)
                    UserDefaults.standard.removeObject(forKey: CURRENCIES)
                    UserDefaults.standard.set(currenciesArray, forKey: CURRENCIES)
                   currencies.append(Currency(title: symbol.title))
                    showSheet = false
                }
            }
            .onAppear{
                vm.getSymbols()
            }
            .navigationTitle("Add new currency")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = false
                    } label: {
                        Image(systemName: "xmark.circle")
                    }

                }
            }
            .environmentObject(balance)
        }

    }
    
    
}

//struct AddCurrencyView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCurrencyView(showSheet: .constant(true))
//    }
//}
