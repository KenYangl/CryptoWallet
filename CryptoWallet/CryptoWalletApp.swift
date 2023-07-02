//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by Ken on 2023/7/2.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.scenePhase) private var scenePhase
    @State private var isAppInBackground = false
    private let appSettings = AppSettings()
    
    private func makeRootView() -> some View {
        let hasWallet = UserService.shared.hasWallet
        if hasWallet {
            return AnyView (
                ZStack {
                    TabBar()
                        .environmentObject(appSettings)
                    // overlayer
                    if isAppInBackground {
                        BlurView(style: .systemChromeMaterialLight)
                            .ignoresSafeArea()
                    }
                }
            )
        } else {
            return AnyView (
                OnboardingView(isHiddenCancelButton: true)
            )
        }
    }

    var body: some Scene {
        WindowGroup {
            makeRootView()
                .preferredColorScheme(colorScheme)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print("App entered background")
                    isAppInBackground = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    isAppInBackground = false
                    print("App didBecomeActiveNotification")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    print("App didEnterBackgroundNotification")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("App willEnterForegroundNotification")
                }
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
