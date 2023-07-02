//
//  WalletSecretPhraseView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/24.
//

import SwiftUI

struct WalletSecretPhraseView: View {
    
    @State private var mnemonicArray: [String] = []
    @State private var showVerifyPhraseView = false
    
    let data: [String] = [
            "Item", "Item", "Itemfggfgf", "Item",
            "Itemfgfgg", "Item", "Item", "Item",
            "Item2323fdff", "Item43434rerer", "Item", "Itembfbfgbf"
        ]
    
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
    
    private func creatPhrasesView(index: Int, text: String) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 0.5)
            .overlay(
                HStack {
                    Text("\(index)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            )
    }
    
    private var phrasesView: some View {
        VStack(spacing: 10) {
            ForEach(0..<data.count, id: \.self) { index in
                creatPhrasesView(index: index + 1, text: data[index])
            }
        }
        .padding()
    }
    
    private var copyButton: some View {
        Button(action: {
            
//            showCreatNewWallet = true
        }) {
            Text("Copy")
                .font(.body)
                .foregroundColor(.blue)
                .padding(.horizontal, 32)
                .padding(.vertical, 10)
                .background(Color.clear)
                .cornerRadius(10)
        }
    }
    
    private var warningTipsView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.red.opacity(0.4))
                .padding(16)
            
            Text("DO NOT share your phrase to anyone as this gives full access to your wallet!\n\n Starry Sky support will NEVER reach out to ask for it")
                .multilineTextAlignment(.center)
                .padding(32)
                .foregroundColor(.red)
                .font(.headline)
        }
    }
    
    private var actionButton: some View {
        Button(action: {
            showVerifyPhraseView = true
        }) {
            Text("继续")
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    private func creatWallet() {
        do {
            let _mnemonicArray = try WalletManager.creatWalletForMnemonicArray()
            mnemonicArray = _mnemonicArray
            print("助记词====\(mnemonicArray)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                tipsView
                ForEach(0..<mnemonicArray.count, id: \.self) { index in
                    Text("\(mnemonicArray[index])")
                }
                copyButton
                warningTipsView
                actionButton
            }
        }
        .onAppear {
//            creatWallet()
        }
        .navigationDestination(isPresented: $showVerifyPhraseView) {
            VerifyPhraseView(mnemonicArray: mnemonicArray)
        }
    }
}

struct WalletSecretPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        WalletSecretPhraseView()
    }
}

struct CustomGridView: View {
    let texts: [String]
    
    @State private var columns: Int = 1
    
    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let cellWidth = calculateCellWidth(width: availableWidth)
            
            let rows = texts.count / columns + (texts.count % columns == 0 ? 0 : 1)
            
            VStack(spacing: 8) {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<columns, id: \.self) { column in
                            if let index = getIndex(row: row, column: column) {
                                CustomCellView(index: index, text: texts[index])
                                    .frame(width: cellWidth)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            self.calculateColumns()
        }
    }
    
    private func calculateColumns() {
        let screenSize = UIScreen.main.bounds.size
        let availableWidth = screenSize.width - 16 // Subtract any desired left/right padding
        let cellWidth = calculateCellWidth(width: availableWidth)
        let calculatedColumns = Int(availableWidth / cellWidth)
        columns = max(calculatedColumns, 1)
    }
    
    private func calculateCellWidth(width: CGFloat) -> CGFloat {
        let minimumCellWidth: CGFloat = 44 // Minimum width of each cell
        let availableWidth = width - CGFloat(columns - 1) * 10 // Subtract the total spacing between columns
        let cellWidth = availableWidth / CGFloat(columns)
        return max(cellWidth, minimumCellWidth)
    }
    
    private func getIndex(row: Int, column: Int) -> Int? {
        let index = row * columns + column
        return index < texts.count ? index : nil
    }
}

struct CustomCellView: View {
    let index: Int
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 0.5)
            .overlay(
                VStack(spacing: 8) {
                    Text("\(index + 1)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 8)
                }
            )
    }
}

