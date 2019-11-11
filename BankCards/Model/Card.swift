//
//  Card.swift
//  BankCards
//
//  Created by Fernando Moya de Rivas on 10/11/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation

enum CardBrand {
    case visa
    case mastercard
    case americanExpress
    case maestro
}

struct Card: Identifiable, Equatable {
    
    static let aspectRatio: Double = 16 / 9
    
    var id: String {
        return number
    }
    
    var number: String
    var holderName: String
    var expiration: String
    var brand: CardBrand
    
}

class Wallet: ObservableObject {
    @Published var cards: [Card]
        
    init(cards: [Card]) {
        self.cards = cards.reversed()
    }
    
    func index(of card: Card) -> Int {
        return cards.count - cards.firstIndex(of: card)! - 1
    }
    
    func isFirst(card: Card) -> Bool {
        return index(of: card) == 0
    }
}

let cards = [
    Card(number: "4761 \t1200 \t1000 \t0492",
         holderName: "F. MOYA DE RIVAS",
         expiration: "02/22",
         brand: .visa),
    Card(number: "5204 \t2477 \t5000 \t1471",
         holderName: "F. MOYA DE RIVAS",
         expiration: "11/21",
         brand: .mastercard),
    Card(number: "6799 \t9989 \t1234 \t106",
         holderName: "F. MOYA DE RIVAS",
         expiration: "06/20",
         brand: .maestro),
    Card(number: "3499 \t569590 \t41362",
         holderName: "F. MOYA DE RIVAS",
         expiration: "03/20",
         brand: .americanExpress)
]
