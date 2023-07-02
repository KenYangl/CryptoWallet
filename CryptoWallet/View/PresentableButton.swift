//
//  PresentableButton.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct PresentableButton: View {
    let title: String
    let destination: AnyView
    @State private var showView = false
    
    var body: some View {
        HStack {
            Button(action: {
                showView = true
            }, label: {
                Text(title)
                    .font(.callout)
                    .foregroundColor(.primary)
            })
            .sheet(isPresented: $showView) {
                destination
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}
