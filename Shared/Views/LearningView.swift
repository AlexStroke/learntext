// LearningView.swift
import SwiftUI

struct LearningView: View {
    @ObservedObject var viewModel: LearningViewModel
    
    private let buttonColor = Color(red: 30 / 255, green: 160 / 255, blue: 200 / 255)
    
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
                        .background(buttonColor)
                        .cornerRadius(22)
                }

                Button(action: {
                    viewModel.speak(viewModel.sentences[viewModel.currentSentenceIndex])
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(buttonColor)
                        .cornerRadius(22)
                }

                Button(action: {
                    viewModel.toggleRepeating()
                }) {
                    Image(systemName: viewModel.isRepeating ? "stop.fill" : "repeat")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(buttonColor)
                        .cornerRadius(22)
                }
                
                Button(action: {
                    viewModel.showNextSentence()
                }) {
                    Image(systemName: "forward.end.fill")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 44)
                        .background(buttonColor)
                        .cornerRadius(22)
                }
            }

            Button(action: {
                viewModel.isLearning = false
            }) {
                Text("Edit Text")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(buttonColor)
            }
            .padding(.top, 20)
        }
    }
}
