import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = LearningViewModel()
    
    private let buttonColor = Color(red: 30 / 255, green: 160 / 255, blue: 200 / 255)
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                if viewModel.isLearning {
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
                } else {
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
                    }) {
                        Text("Start Learning")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 44)
                            .background(buttonColor)
                            .cornerRadius(22)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
