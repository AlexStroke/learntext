import Foundation
import AVFoundation

class LearningViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    #if DEBUG
    @Published var userText: String = "My name is Alexander, and I am a highly motivated and adaptable Quality Assurance engineer with a diverse background and over five years of experience in QA Engineering. I have been honing my expertise in functional testing for software, as well as test automation using Python with PyTest. I have a proven track record of working effectively in diverse teams and delivering high-quality results. I have worked with five well-established IT companies, such as Radario, Ailet Solutions, Tinkoff bank, United Credit Bureau, and currently Soramitsu, where I've been responsible for maintaining and improving test frameworks, validating software configurations, and providing technical support to development teams. I am highly focused and have a strong passion for work, learning, and personal development. I am a quick learner and excel at planning and organizing my work to ensure tasks are completed on time and to the highest standards. Additionally, I enjoy working as part of a team and am always eager to contribute my skills and knowledge to help achieve the team's goals. I believe my diverse background and expertise make me an ideal candidate for the Software Engineer in Test role at XM company. I am excited about the opportunity to work in a FinTech environment, focus on building transformative technology, and further develop my skills while contributing to the company's growth and success. Also, I am attracted to the company's strong corporate values, commitment to employee development, and emphasis on a supportive and open-minded work environment. I am confident that my skills, experience, and enthusiasm will enable me to make a significant contribution to XM company and help the company achieve its quality objectives."
    #else
    @Published var userText: String = ""
    #endif
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
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func splitTextIntoSentences(text: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: "[^.!?]+[.!?]+")
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        return matches.map { match in
            let range = Range(match.range, in: text)!
            return String(text[range])
        }
    }
    
    func showNextSentence() {
        currentSentenceIndex = (currentSentenceIndex + 1 + sentences.count) % sentences.count
        speak(sentences[currentSentenceIndex])
    }
    
    func showPreviousSentence() {
        currentSentenceIndex = (currentSentenceIndex - 1 + sentences.count) % sentences.count
        speak(sentences[currentSentenceIndex])
    }
    
    func speak(_ text: String) {
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

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if isRepeating {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.speak(self.sentences[self.currentSentenceIndex])
            }
        }
    }
}
