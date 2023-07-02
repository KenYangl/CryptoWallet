//
//  WalletRow.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct WalletRow: View {
    var title: String
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
                .foregroundColor(.red)
                .frame(width: 58, height: 58, alignment: .center)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    
                Text("Multi-Coin Wallet")
                    .font(.footnote)
                    .foregroundColor(.blue.opacity(0.8))
            }
            Spacer()
            Button(action: {
                onTap?()
            }, label: {
                Text("More")
            })
        }
    }
}

struct WalletRow_Previews: PreviewProvider {
    static var previews: some View {
        WalletRow(title: "My Wallet")
    }
}
