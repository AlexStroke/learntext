// EditingView.swift
import SwiftUI

struct EditingView: View {
    @ObservedObject var viewModel: LearningViewModel
    
    private let buttonColor = Color(red: 30 / 255, green: 160 / 255, blue: 200 / 255)
    
    var body: some View {
        VStack {
            Text("Enter your text:")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            TextEditor(text: $viewModel.userText)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
                .frame(height: 200)

            Button(action: {
                viewModel.showingVoicePicker = true
            }) {
                HStack {
                    Text(viewModel.selectedVoice?.name ?? "Select Voice")
                        .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $viewModel.showingVoicePicker) {
                NavigationView {
                    List {
                        ForEach(viewModel.availableVoices, id: \.self) { voice in
                            Button(action: {
                                viewModel.selectedVoice = voice
                                viewModel.showingVoicePicker = false
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
                viewModel.sentences = viewModel.splitTextIntoSentences(text: viewModel.userText)
                viewModel.isLearning = true
                viewModel.speak(viewModel.sentences[viewModel.currentSentenceIndex])
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
