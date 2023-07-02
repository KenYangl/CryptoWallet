//
//  BrowserView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/22.
//

import SwiftUI

struct BrowserView: View {
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 98)
                    .foregroundColor(Color.blue)
                VStack {
//                    Spacer()
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("0")
                        })
                        .padding()
                        
                        TextField("Search or enter website url", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .focused($isTextFieldFocused)
                        
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(Color.white)
                        })
                        .opacity(isTextFieldFocused ? 1 : 0)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: 44)
                }
//                Spacer()
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
