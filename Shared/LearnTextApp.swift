//
//  LearnTextApp.swift
//  Shared
//
//  Created by Александр Строков on 16.04.2023.
//

import SwiftUI

@main
struct LearnTextApp: App {
    @StateObject private var voiceSettings = VoiceSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(voiceSettings)
        }
    }
}
