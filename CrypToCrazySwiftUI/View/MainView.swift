//
//  ContentView.swift
//  CrypToCrazySwiftUI
//
//  Created by Oğuzhantuğrul Akçay on 16.06.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init(){
        self.cryptoListViewModel=CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView{
            List(cryptoListViewModel.cryptoList,id:\.id){ crypto in
                VStack{
                    Text(crypto.currency)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(crypto.price)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                
            }
            .toolbar(content: {
                Button {
                    //tıknamınca ne olacak
                    Task.init {
//                        cryptoListViewModel.cryptoList=[]
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDATASET/master/crypto.json")!)
                        
                    }
                } label: {
                    Text("Refresh")
                }

            })
            .navigationTitle("Crypto Crazy")
        }
        .task {
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDATASET/master/crypto.json")!)
//            await cryptoListViewModel.downloadCryptos(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDATASET/master/crypto.json")!)
        }
//        .onAppear{
//            
//            cryptoListViewModel.downloadCryptos(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDATASET/master/crypto.json")!)
//        }
    }
}

#Preview {
    MainView()
}
