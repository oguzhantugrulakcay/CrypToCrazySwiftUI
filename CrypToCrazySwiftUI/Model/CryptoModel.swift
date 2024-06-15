//
//  Models.swift
//  CrypToCrazySwiftUI
//
//  Created by Oğuzhantuğrul Akçay on 16.06.2024.
//

import Foundation

struct CryptoModel : Decodable, Identifiable{
    let id = UUID()
    let currency : String
    let price : String
    
    
    //id gelmeyecek ama struct kendisi id yi oluşturavilecek
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}
