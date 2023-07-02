//
//  WalletsView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct WalletsView: View {
    @State private var showOnboardingView = false
    
    private var addButton: some View {
        Button(action: {
            showOnboardingView = true
        }) {
            Text("settings_wallets_add_wallet".localized)
                .foregroundColor(.blue)
                .font(.headline)
        }
    }
    
    var body: some View {
        List {
            Section("settings_wallets_multi_coin_wallets".localized) {
                
                let wallets = UserService.shared.wallets
                ForEach(wallets) { wallet in
                    NavigationLink(destination: WalletEditView(walletName: "My Wallet")) {
                        WalletRow(title: wallet.name) {
                            print("taped more")
                        }
                    }
                }
                
            }
        }
        .toolbar(content: {
            addButton
                .sheet(isPresented: $showOnboardingView) {
                    OnboardingView(isHiddenCancelButton: false)
                }
        })
        .navigationTitle("settings_wallets_navigation_title".localized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WalletsView_Previews: PreviewProvider {
    static var previews: some View {
        WalletsView()
    }
}
