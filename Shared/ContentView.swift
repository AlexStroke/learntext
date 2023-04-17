import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = LearningViewModel()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                if viewModel.isLearning {
                    LearningView(viewModel: viewModel)
                } else {
                    EditingView(viewModel: viewModel)
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
