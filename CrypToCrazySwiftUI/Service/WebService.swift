//
//  WebService.swift
//  CrypToCrazySwiftUI
//
//  Created by Oğuzhantuğrul Akçay on 16.06.2024.
//

import Foundation

class WebService{
    
    /*
    func downloadCurrenciesAsync(url:URL) async throws -> [CryptoModel] {
        let (data,_) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode([CryptoModel].self, from: data)
        
        return currencies ?? []
    }*/
    
    func downloadCurrenciesContinuation(url:URL)async throws -> [CryptoModel]{
        try await withCheckedThrowingContinuation { continuation in
            downloadCurrencies(url: url){ result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
                
            }
        }
    }
    
    func downloadCurrencies(url: URL, completion: @escaping(Result<[CryptoModel]?,DownloaderError>)->Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
                    
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.badUrl))
                }
                    
                guard let data = data, error == nil else {
                    return completion(.failure(.noData))
                }
                    
                guard let currencies = try? JSONDecoder().decode([CryptoModel].self, from: data) else {
                    return completion(.failure(.dataParseError))
                }
                    completion(.success(currencies))
                }.resume()
    }
     
}

enum DownloaderError:Error{
    case badUrl
    case noData
    case dataParseError
}
