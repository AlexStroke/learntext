import Foundation
import AVFoundation


class LearningViewModel: ObservableObject {
    @Published var userText: String = ""
    @Published var sentences: [String] = []
    @Published var currentSentenceIndex = 0
    @Published var isRepeating = false
    @Published var isLearning = false
    @Published var availableVoices: [AVSpeechSynthesisVoice] = AVSpeechSynthesisVoice.speechVoices().filter { if #available(iOS 16.0, *) {
        $0.quality == .enhanced || $0.quality == .premium
    } else {
    }; return $0.quality == .enhanced || $0.quality == .default }
    @Published var selectedVoice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice(identifier: "com.apple.voice.enhanced.en-US.Evan")
    @Published var showingVoicePicker = false

    private var synthesizer = AVSpeechSynthesizer()
    
    func splitTextIntoSentences(text: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: "[^.!?]+[.!?]+")
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        return matches.map { match in
            let range = Range(match.range, in: text)!
            return String(text[range])
        }
    }
    
    func showNextSentence() {
        currentSentenceIndex = (currentSentenceIndex + 1) % sentences.count
        if isRepeating {
            speak(sentences[currentSentenceIndex])
        }
    }
    
    func showPreviousSentence() {
        currentSentenceIndex = (currentSentenceIndex - 1) % sentences.count
        if isRepeating {
            speak(sentences[currentSentenceIndex])
        }
    }
    
    func speak(_ text: String) {
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if voice.language.hasPrefix("en") {
                print("Language: \(voice.language), Identifier: \(voice.identifier), Name: \(voice.name)")
            }
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = selectedVoice
        utterance.rate = 0.4

        synthesizer.speak(utterance)
    }
    
    func toggleRepeating() {
        isRepeating.toggle()
        
        if isRepeating {
            speak(sentences[currentSentenceIndex])
        }
    }
}
