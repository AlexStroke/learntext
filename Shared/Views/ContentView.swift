import SwiftUI
import AVFoundation

enum Screen {
    case editing
    case learning
    case trainingSelecting
}

struct ContentView: View {
    @StateObject private var learningViewModel = LearningViewModel()
    @StateObject private var editingViewModel = EditingViewModel()
    
    @State private var currentScreen: Screen = .editing
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                switch currentScreen {
                case .editing:
                    EditingView(editingViewModel: editingViewModel, currentScreen: $currentScreen)
                case .learning:
                    LearningView(viewModel: learningViewModel, currentScreen: $currentScreen)
                case .trainingSelecting:
                    TrainingSelectionView(editingViewModel: editingViewModel, currentScreen: $currentScreen)
                }
            }
            .padding()
        }
        .environmentObject(editingViewModel)
        .environmentObject(learningViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
