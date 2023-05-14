// LearningView.swift
import SwiftUI

struct LearningView: View {
    @ObservedObject var viewModel: LearningViewModel
    @Binding var currentScreen: Screen
    
    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.sentences[viewModel.currentSentenceIndex])
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()

            HStack(spacing: 20) {
                Button(action: {
                    viewModel.showPreviousSentence()
                }) {
                    Image(systemName: "backward.end.fill")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(GlobalColors.buttonColor)
                        .cornerRadius(22)
                }

                Button(action: {
                    viewModel.speak(viewModel.sentences[viewModel.currentSentenceIndex])
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(GlobalColors.buttonColor)
                        .cornerRadius(22)
                }

                Button(action: {
                    viewModel.toggleRepeating()
                }) {
                    Image(systemName: viewModel.isRepeating ? "stop.fill" : "repeat")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(GlobalColors.buttonColor)
                        .cornerRadius(22)
                }
                
                Button(action: {
                    viewModel.showNextSentence()
                }) {
                    Image(systemName: "forward.end.fill")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(GlobalColors.buttonColor)
                        .cornerRadius(22)
                }
            }

            Button(action: {
                self.currentScreen = .editing
            }) {
                Text("Edit Text")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(GlobalColors.buttonColor)
            }
            .padding(.top, 20)
        }
    }
}
