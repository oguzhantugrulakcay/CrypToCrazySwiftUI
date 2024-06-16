//
//  CryptoViewModel.swift
//  CrypToCrazySwiftUI
//
//  Created by Oğuzhantuğrul Akçay on 16.06.2024.
//

import Foundation

@MainActor
//Bunu koyunca main trahe'te çalışması için dispatchqueue kotmana gerek olmuyor

class CryptoListViewModel : ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
     
    let webservice = WebService()
    
    
    func downloadCryptosContinuation(url:URL) async {
        do{
            let cryptos = try await webservice.downloadCurrenciesContinuation(url: url)
            
//            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
//            }
            
        } catch {
            print (error)
        }
    }
    
    /*
    func downloadCryptos(url:URL) async{
        do{
            let cryptos = try await webservice.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print(error)
        }
    }*/
    
    /*
    func downloadCryptos (url: URL) {
        webservice.downloadCurrencies(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cryptos):
                if let cryptos=cryptos{
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
                }
            }
        }
    }*/
}

struct CryptoViewModel {
    let crypto : CryptoModel
    
    var id : UUID?{
        crypto.id
    }
    
    var currency : String {
        crypto.currency
    }
    
    var price : String{
        crypto.price
    }
}
