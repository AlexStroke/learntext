// EditingView.swift
import SwiftUI

struct EditingView: View {
    @ObservedObject var editingViewModel: EditingViewModel
    @EnvironmentObject var learningViewModel: LearningViewModel
    @Binding var currentScreen: Screen
        
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
                self.currentScreen = .trainingSelecting
                learningViewModel.selectedVoice = editingViewModel.selectedVoice
            }) {
                Text("Choose training")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 44)
                    .background(GlobalColors.buttonColor)
                    .cornerRadius(22)
            }
        }
    }
}
