//
//  HomeView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                
                Button {
                    print("taped settings")
                } label: {
                    Image(systemName: "gearshape")
                        .frame(width: 40, height: 40)
                }
                
                Spacer()

                Text("Swipe from left edge")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .modifier(SwipeGestureModifier())
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 40))
                    .modifier(SwipeGestureModifier())
            }
        }
        .onAppear {
            if let user = UserService.shared.obtainingUser() {
                print(user.wallets.first?.mnemonics)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
