//
//  NavigationBar.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct NavigationBar: View {
    let title: String
    let leftButtonTitle: String
    let leftButtonAction: () -> Void
    let rightButtonTitle: String?
    let rightButtonAction: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: leftButtonAction) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(leftButtonTitle)
                    }
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                if let rightButtonTitle = rightButtonTitle, let rightButtonAction = rightButtonAction {
                    Button(action: rightButtonAction) {
                        Text(rightButtonTitle)
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}
