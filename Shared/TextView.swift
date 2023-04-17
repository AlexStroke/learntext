import SwiftUI

struct TextView: View {
    @Binding var userText: String

    var body: some View {
        VStack {
            Text("Enter your text:")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            TextEditor(text: $userText)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
                .frame(height: 200)
        }
    }
}
