//
//  VerifyPhraseView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/28.
//

import SwiftUI

struct VerifyPhraseView: View {
    @State private var showxxxx = false
    @EnvironmentObject private var appSettings: AppSettings
    @Environment(\.presentationMode) var presentationMode
    var mnemonicArray: [String]
//    @State private var popToRootView = false
    
    private var tipsView: some View {
        VStack(spacing: 5) {
            Text("Your Secret Phrase")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Write down or copy these words in the right order and save them somewhere safe.")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private var actionButton: some View {
        Button(action: {
            store()
//            presentationMode.wrappedValue.dismiss()
            gotoHome()
        }) {
            Text("继续") // 创建成功,保存钱包 并跳转到首页
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    var body: some View {
        VStack {
            tipsView
            Spacer()
            actionButton
        }
        .padding()
    }
    
    private func gotoHome() {
//        appSettings.selectedTab = .home
    }
    
    private func store() {
        UserService.shared.store(mnemonics: "afa 455 gd hht 4545 aff 3434 sgeg ", walletName: nil, walletSelected: true)
    }
}

struct VerifyPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyPhraseView(mnemonicArray: ["test", "test1"])
    }
}
