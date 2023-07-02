//
//  SettingsRow.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/23.
//

import SwiftUI

struct SettingsRow: View {
    enum AccessoryType {
        case none
        case arrow
        case text(String)
        case textArrow(String)
        case toggle(Binding<Bool>)
    }
    
    let title: String
    let accessoryType: AccessoryType
    var onTap: (() -> Void)?
    @State private var isActive = false
    
    var body: some View {
        HStack {
            Text(title).font(.callout)
            Spacer()
            settingsItemView()
        }
    }
    
    @ViewBuilder
    private func settingsItemView() -> some View {
        switch accessoryType {
        case .none:
            EmptyView()
        case .arrow:
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        case .text(let text):
            Text(text)
                .foregroundColor(.gray)
        case .toggle(let isOn):
            Toggle("", isOn: isOn)
                .labelsHidden()
        case .textArrow(let text):
            HStack {
                Text(text)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .foregroundColor(.primary)
    }
}
