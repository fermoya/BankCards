//
//  CardBrand+SwiftUI.swift
//  BankCards
//
//  Created by Fernando Moya de Rivas on 12/11/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import Foundation
import SwiftUI

extension CardBrand {
    var logoName: String {
        switch self {
        case .visa:
            return "visa-logo"
        case .mastercard:
            return "mastercard-logo"
        case .americanExpress:
            return "american-express-logo"
        case .maestro:
            return "maestro-logo"
        }
    }
    
    var shadowColor: Color {
        return .gray
    }
    
    var highlightedColor: Color {
        switch self {
        case .visa:
            return .white
        case .mastercard:
            return .black
        case .americanExpress:
            return .white
        case .maestro:
            return .black
        }
    }
    
    var gradient: Gradient {
        switch self {
        case .visa:
            return Gradient(colors: [
                Color(.sRGB, red: 38 / 255, green: 63 / 255, blue: 159 / 255, opacity: 1),
                Color(.sRGB, red: 174 / 255, green: 77 / 255, blue: 1, opacity: 1)])
        case .mastercard:
            return Gradient(colors: [
                Color(.sRGB, red: 1, green: 26 / 255, blue: 34 / 255, opacity: 1),
                Color(.sRGB, red: 1, green: 190 / 255, blue: 0, opacity: 1)])
        case .americanExpress:
            return Gradient(colors: [
                Color(.sRGB, red: 11 / 255, green: 11 / 255, blue: 11 / 255, opacity: 1),
                Color(.sRGB, red: 97 / 255, green: 97 / 255, blue: 97 / 255, opacity: 1)])
        case .maestro:
            return Gradient(colors: [
                Color(.sRGB, red: 2 / 255, green: 136 / 255, blue: 209 / 255, opacity: 1),
                Color(.sRGB, red: 1, green: 24 / 255, blue: 55 / 255, opacity: 1)])
        }
    }
}
