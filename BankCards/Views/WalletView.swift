//
//  ContentView.swift
//  BankCards
//
//  Created by Fernando Moya de Rivas on 10/11/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    
    private static let cardOffset: CGFloat = -20
    private static let cardOpacity: Double = 0.05
    private static let cardShrinkRatio: CGFloat = 0.05
    private static let cardRotationAngle: Double = 30
    private static let cardScaleWhenDragginDown: CGFloat = 1.1
    private static let padding: CGFloat = 20

    @EnvironmentObject var wallet: Wallet
    @State var extraOffset: CGFloat = 0
    @State var isDragging: Bool = false
    @State var scale: CGFloat = Self.cardScaleWhenDragginDown

    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                ForEach(self.wallet.cards) { card in
                    CardView(card: card)
                        .opacity(1 - Double(self.wallet.index(of: card)) * Self.cardOpacity)
                        .offset(x: 0,
                                y: CGFloat(self.wallet.index(of: card)) * Self.cardOffset + (self.wallet.isFirst(card: card) ? self.extraOffset : 0))
                        .scaleEffect((self.isDragging && self.wallet.isFirst(card: card)) ? self.scale : 1 - CGFloat(self.wallet.index(of: card)) * Self.cardShrinkRatio)
                        .rotation3DEffect(Angle(degrees: (self.wallet.isFirst(card: card) || self.isDragging ) ? 0 : Self.cardRotationAngle), axis: (x: 0.5, y: 1, z: 0))
                        .gesture(
                            DragGesture()
                                .onChanged(self.dragGestureDidChange(value:))
                                .onEnded({ (value) in
                                    self.dragGestureDidEnd(value: value,
                                                           card: card,
                                                           geometry: geometry)
                                }))
                        .disabled(!self.wallet.isFirst(card: card))
                }
            }.padding(.horizontal, Self.padding)
        }
    }
}

extension WalletView {
    
    func dragGestureDidChange(value: DragGesture.Value) {
        withAnimation {
            self.extraOffset = value.translation.height
            self.isDragging = true
            self.scale = self.extraOffset > 0 ? Self.cardScaleWhenDragginDown : (1 - CGFloat(self.wallet.cards.count) * Self.cardShrinkRatio)
        }
    }
    
    func dragGestureDidEnd(value: DragGesture.Value, card: Card, geometry: GeometryProxy) {
        withAnimation(.spring()) {
            self.extraOffset = 0
            
            let cardHeight = (geometry.size.width / CGFloat(Card.aspectRatio) - Self.padding)
            if abs(value.translation.height + CGFloat(self.wallet.cards.count) * -Self.cardOffset) > cardHeight {
                let newCards = [card] + Array(self.wallet.cards.dropLast())
                self.wallet.cards = newCards
            }
            
            self.isDragging = false
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView().environmentObject(Wallet(cards: cards))
    }
}
