//
//  CardView.swift
//  BankCards
//
//  Created by Fernando Moya de Rivas on 10/11/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .center, spacing: 0) {
                Group {
                    Spacer()
                    HStack(alignment: .center) {
                        self.chip(for: geometry)
                        Spacer()
                        self.contactLess(for: geometry)
                    }.padding(.horizontal)
                    VStack(spacing: 5) {
                        self.cardNumber
                        self.expiration
                    }.padding(.bottom, geometry.size.height / 100)
                    ZStack(alignment: .center) {
                        self.cardHolderName
                        HStack {
                            Spacer()
                            self.cardLogo(for: geometry)
                        }
                    }.padding(.horizontal)
                    Spacer()
                }.shadow(color: self.card.brand.shadowColor, radius: 5, x: 0, y: 0)
            }.frame(width: geometry.size.width,
                    height: geometry.size.width / CGFloat(Card.aspectRatio))
                .background(LinearGradient(gradient: self.card.brand.gradient,
                                           startPoint: UnitPoint(x: 0, y: 1), endPoint: UnitPoint(x: 1, y: 0)))
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

// MARK: Subviews

extension CardView {
    
    var expiration: some View {
        VStack(alignment: .center, spacing: 3) {
            Group {
                Text("MONTH/YEAR").font(.system(size: 12))
                Text(card.expiration).font(.system(size: 15))
            }
            .foregroundColor(card.brand.highlightedColor)
        }
    }
    
    func cardLogo(for geometry: GeometryProxy) -> some View {
        Image(card.brand.logoName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: geometry.size.height / 18)
            .fixedSize()
    }
    
    var cardHolderName: some View {
        Text("F. MOYA DE RIVAS")
            .foregroundColor(card.brand.highlightedColor)
            .minimumScaleFactor(2)
            .font(.system(size: 16))
            .shadow(radius: 3)
            .padding(.horizontal)
    }
    
    var cardNumber: some View {
        Text(card.number)
            .foregroundColor(card.brand.highlightedColor)
            .font(.system(size: 23, weight: .medium))
    }
    
    func chip(for geometry: GeometryProxy) -> some View {
        Image("chip")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: geometry.size.height / 12)
            .fixedSize()
    }
    
    func contactLess(for geometry: GeometryProxy) -> some View {
        Image(systemName: "radiowaves.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geometry.size.height / 30)
            .foregroundColor(card.brand.highlightedColor)
            .fixedSize()
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11", "iPhone 11 Pro Max"], id: \.self) {
            CardView(card: cards[2])
                .padding(32)
                .previewDevice(.init(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
