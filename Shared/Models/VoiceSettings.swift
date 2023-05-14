//
//  VoiceSettings.swift
//  LearnText
//
//  Created by Александр Строков on 28.04.2023.
//

import Foundation
import AVFoundation

class VoiceSettings: ObservableObject {
    @Published var selectedVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice(identifier: "com.apple.voice.premium.en-US.Ava")
}
