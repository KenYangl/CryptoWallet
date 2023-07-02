//
//  LearnView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct LearnView: View {
    @State private var showSafariView = false
    var body: some View {
        List {
            Section(header: Text("settings_learn_intro_to_nft".localized)) {
                LearnRow(title: "settings_learn_what_is_nft_".localized, urlString: "https://opensea.io/learn/what-are-nfts")
                LearnRow(title: "settings_learn_how_buy_nft".localized, urlString: "https://opensea.io/learn/how-to-buy-nft")
                LearnRow(title: "settings_learn_what_nft_drops".localized, urlString: "https://opensea.io/learn/what-are-nft-drops")
                LearnRow(title: "settings_learn_how_creat_nft".localized, urlString: "https://opensea.io/learn/how-to-create-an-nft")
                LearnRow(title: "settings_learn_what_is_mint".localized, urlString: "https://opensea.io/learn/what-is-minting-nft")
                LearnRow(title: "settings_learn_what_are_redeemble_nft".localized, urlString: "https://opensea.io/learn/what-are-redeemable-nfts")
                LearnRow(title: "settings_learn_how_sell_nft".localized, urlString: "https://opensea.io/learn/how-to-sell-nfts")
                LearnRow(title: "settings_learn_what_art_nft".localized, urlString: "https://opensea.io/learn/art-nfts")
                LearnRow(title: "settings_learn_what_music_art".localized, urlString: "https://opensea.io/learn/what-are-music-nfts")
            }
            
            Section(header: Text("settings_learn_intro_to_web3".localized)) {
                LearnRow(title: "settings_learn_what_is_web3".localized, urlString: "https://opensea.io/learn/what-is-web3")
                LearnRow(title: "settings_learn_what_is_crypto_currency".localized, urlString: "https://opensea.io/learn/what-is-cryptocurrency")
                LearnRow(title: "settings_learn_what_is_crypto_wallet".localized, urlString: "https://opensea.io/learn/what-is-crypto-wallet")
                LearnRow(title: "settings_learn_what_is_dao".localized, urlString: "https://opensea.io/learn/what-is-a-dao")
                LearnRow(title: "settings_learn_protected_in_web3".localized, urlString: "https://opensea.io/learn/how-to-stay-protected-in-web3")
                LearnRow(title: "settings_learn_what_is_metaverse".localized, urlString: "https://opensea.io/learn/what-is-the-metaverse")
                LearnRow(title: "settings_learn_what_is_metamask_wallet".localized, urlString: "https://opensea.io/learn/metamask-wallet-what-to-know")
                LearnRow(title: "settings_learn_what_is_coinbase_wallet".localized, urlString: "https://opensea.io/learn/coinbase-wallet-what-to-know")
            }
            
            Section(header: Text("settings_learn_intro_to_blockchain_basic".localized)) {
                LearnRow(title: "settings_learn_what_is_blockchain".localized, urlString: "https://opensea.io/learn/what-is-blockchain")
                LearnRow(title: "settings_learn_what_is_gas_fees".localized, urlString: "https://opensea.io/learn/nft-gas-fees")
                LearnRow(title: "settings_learn_what_is_ethereum".localized, urlString: "https://opensea.io/learn/what-is-ethereum")
                LearnRow(title: "settings_learn_what_is_WETH".localized, urlString: "https://opensea.io/learn/what-is-weth")
                LearnRow(title: "settings_learn_what_is_Arbitrum".localized, urlString: "https://opensea.io/learn/what-is-arbitrum")
                LearnRow(title: "settings_learn_what_is_Polygon".localized, urlString: "https://opensea.io/learn/what-is-polygon")
                LearnRow(title: "settings_learn_what_is_Etherscan".localized, urlString: "https://opensea.io/learn/what-is-etherscan")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("settings_learn_nft_journey_navigation_title".localized)
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
