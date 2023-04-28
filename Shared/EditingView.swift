// EditingView.swift
import SwiftUI

struct EditingView: View {
    @ObservedObject var editingViewModel: EditingViewModel
    @EnvironmentObject var learningViewModel: LearningViewModel
    
    private let buttonColor = Color(red: 30 / 255, green: 160 / 255, blue: 200 / 255)
    
    var body: some View {
        VStack {
            Text("Enter your text:")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            TextEditor(text: $editingViewModel.userText)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
                .frame(height: 200)

            Button(action: {
                editingViewModel.showingVoicePicker = true
            }) {
                HStack {
                    Text(editingViewModel.selectedVoice?.name ?? "Select Voice")
                        .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $editingViewModel.showingVoicePicker) {
                NavigationView {
                    List {
                        ForEach(editingViewModel.availableVoices, id: \.self) { voice in
                            Button(action: {
                                editingViewModel.selectedVoice = voice
                                editingViewModel.showingVoicePicker = false
                            }) {
                                Text(voice.name)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .navigationTitle("Select Voice")
                }
            }

            Button(action: {
                learningViewModel.selectedVoice = editingViewModel.selectedVoice
                learningViewModel.sentences = learningViewModel.splitTextIntoSentences(text: editingViewModel.userText)
                learningViewModel.isLearning = true
                learningViewModel.speak(learningViewModel.sentences[learningViewModel.currentSentenceIndex])
            }) {
                Text("Start Learning")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 44)
                    .background(buttonColor)
                    .cornerRadius(22)
            }
        }
    }
}
