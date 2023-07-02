//
//  LearnRow.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI
import SafariServices

struct LearnRow: View {
    let title: String
    let urlString: String
    @State private var showSafariView = false
    
    var body: some View {
        HStack {
            Button(action: {
                showSafariView = true
            }, label: {
                Text(title)
                    .font(.callout)
                    .foregroundColor(.primary)
            })
            .sheet(isPresented: $showSafariView) {
                SafariView(url: URL(string: urlString)!)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
