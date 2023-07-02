//
//  SecurityView.swift
//  CryptoWallet
//
//  Created by Ken on 2023/6/25.
//

import SwiftUI

struct SecurityView: View {
    @State private var autoAppLock = false
    @State private var faceIDEnabled = false
    @State private var twoFAEnabled = false
    @State private var showSetPassword = false
    
    var body: some View {
        List {
            SettingsRow(title: "settings_auto_app_lock".localized, accessoryType: .toggle($autoAppLock))
                .onChange(of: autoAppLock) { newValue in
                    showSetPassword = newValue
                    BiometricService.shared.evaluate(with: BiometricService.shared.biometryType)
                }
            
            if autoAppLock {
                Section {
                    NavigationLink(destination: AppLockView()) {
                        SettingsRow(title: "Auto-Lock", accessoryType: .text("Immediate"))
                    }
                    
                    NavigationLink(destination: AppLockMethodView()) {
                        SettingsRow(title: "Lock Method", accessoryType: .text("Passcode"))
                    }
                    
//                    SettingsRow(title: "settings_enable_face_id".localized, accessoryType: .toggle($faceIDEnabled))
//                        .onChange(of: faceIDEnabled) { newValue in
//                            // 按钮状态发生变化时执行的代码
//                            print("faceIDEnabled is now \(newValue ? "on" : "off")")
//                        }
                    SettingsRow(title: "settings_enable_2_factor_authentication".localized, accessoryType: .toggle($twoFAEnabled))
                        .onChange(of: twoFAEnabled) { newValue in
                            // 按钮状态发生变化时执行的代码
                            print("twoFAEnabled is now \(newValue ? "on" : "off")")
                        }
                }
            }
        }
        .navigationTitle("settings_security_navigation_title".localized)
        .sheet(isPresented: $showSetPassword) {
            PasscodeView(autoAppLock: $autoAppLock, showSetPassword: $showSetPassword)
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
