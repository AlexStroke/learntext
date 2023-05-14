// EditingViewModel.swift
import SwiftUI
import AVFoundation

class EditingViewModel: ObservableObject {
    @Published var userText: String = DebugSettings.defaultUserText
    @Published var availableVoices: [AVSpeechSynthesisVoice] = EditingViewModel.filterAvailableVoices()
    @Published var selectedVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice(identifier: "com.apple.voice.premium.en-US.Ava")
    @Published var showingVoicePicker = false
    
    static func filterAvailableVoices() -> [AVSpeechSynthesisVoice] {
        return AVSpeechSynthesisVoice.speechVoices().filter { voice in
            if #available(iOS 16.0, *) {
                return voice.quality == .enhanced || voice.quality == .premium
            } else {
                return voice.quality == .enhanced || voice.quality == .default
            }
        }
    }
}

