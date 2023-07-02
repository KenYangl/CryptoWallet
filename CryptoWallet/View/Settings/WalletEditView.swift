//
//  WalletEditView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct WalletEditView: View {
    @State var walletName: String
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 4) {
                Text("Name")
                TextField("Name", text: $walletName)
            }
            
            Section {
                NavigationLink(destination: WalletSecretPhraseView()) {
                    HStack {
                        Image(systemName: "house")
                        Text("Show Secret Phrase")
                        Spacer()
                    }
                }
            } header: {
                Text("Backup Options")
            } footer: {
                Text("If you lose access to this device, your funds will be lost, unless you back up!")
            }
        }
            .navigationTitle("Wallet")
    }
}

struct WalletEditView_Previews: PreviewProvider {
    static var previews: some View {
        WalletEditView(walletName: "My Wallet")
    }
}
