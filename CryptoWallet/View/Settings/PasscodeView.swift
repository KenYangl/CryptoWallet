//
//  PasscodeView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import SwiftUI

struct PasscodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var autoAppLock: Bool
    @Binding var showSetPassword: Bool
    @State private var inputPasscode: String = ""
    @State private var title: String = "Creat Passcode"
    
    private var cancelButton: some View {
        Button("Cancel", action: {
            print("Tapped cancel")
            autoAppLock = false
            showSetPassword = false
            presentationMode.wrappedValue.dismiss()
        })
    }
    
    private var passcodeTextField: some View {
        ZStack {
            HStack(spacing: 15) {
                ForEach(0..<6) { _ in
                    Image(systemName: "circle")
                }
            }
            
            TextField("", text: $inputPasscode)
                .keyboardType(.numberPad)
//                .textFieldStyle(.roundedBorder)
                .foregroundColor(.clear)
                .onChange(of: inputPasscode) { newValue in
                    print("Input changed to: \(newValue)")
                    if newValue.count == 6 {
                        title = "Confirm Password"
                    }
                }
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            HStack {
                cancelButton
                Spacer()
                Text("Set Passcode")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            Spacer()
            Text(title)
            passcodeTextField
            Text("Adds an extra layer of security when using the app")
            Spacer()
        }
        .padding()
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeView(autoAppLock: Binding.constant(false), showSetPassword: Binding.constant(false))
    }
}
