import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var learningViewModel = LearningViewModel()
    @StateObject private var editingViewModel = EditingViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                if learningViewModel.isLearning {
                    LearningView(viewModel: learningViewModel)
                } else {
                    EditingView(editingViewModel: editingViewModel)
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
