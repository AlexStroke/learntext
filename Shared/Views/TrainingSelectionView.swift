// TrainingSelectionView.swift
import SwiftUI

struct TrainingSelectionView: View {
    @EnvironmentObject var learningViewModel: LearningViewModel
    
    var body: some View {
        VStack {
            Text("Choose Training")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button(action: {
                // Brainstorming not yet implemented
                print("Brainstorming training selected")
            }) {
                TrainingCardView(title: "Brainstorming", description: "This training is not yet implemented.")
            }
            .disabled(true) // Disable this button as the training is not yet implemented
            
            Button(action: {
                learningViewModel.isLearning = true
            }) {
                TrainingCardView(title: "Survey", description: "Start learning with the Survey training.")
            }
            
            Spacer()
        }
        .padding()
    }
}

struct TrainingCardView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(description)
                .font(.body)
                .foregroundColor(.white)
                .padding(.top, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.vertical, 10)
    }
}

struct TrainingSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingSelectionView()
    }
}
