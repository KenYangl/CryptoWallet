//
//  OnboardingView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showCreatNewWallet = false
    @State private var showImportWallet = false
    let isHiddenCancelButton: Bool
    
    private var cancelButton: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }){
                Text("settings_phrase_cancel".localized)
                    .padding()
            }
            Spacer()
        }
    }
    
    private var creatButton: some View {
        Button(action: {
            showCreatNewWallet = true
        }) {
            Text("settings_phrase_creat_new_wallet".localized)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
        
    private var importButton: some View {
        Button(action: {
            showImportWallet = true
        }) {
            Text("settings_phrase_import_wallet".localized)
                .foregroundColor(.blue)
                .padding()
                .background(Color.clear)
        }
    }
    
    private var actionButtons: some View {
        VStack(spacing: 10) {
            creatButton
            importButton
        }
    }
    
    private var contentView: some View {
        VStack {
//            isHiddenCancelButton ? EmptyView() : cancelButton
//            cancelButton
            Spacer()
            actionButtons
        }
    }

    var body: some View {
        NavigationStack {
            contentView
            .padding()
            .navigationDestination(isPresented: $showCreatNewWallet) {
                WalletSecretPhraseView()
            }
            .navigationDestination(isPresented: $showImportWallet) {
                ImportWalletView()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isHiddenCancelButton: false)
    }
}
