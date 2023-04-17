import SwiftUI

struct ControlButtons: View {
    var onNext: () -> Void
    var onPlay: () -> Void
    var onRepeat: () -> Void
    var isRepeating: Bool

    private let buttonColor = Color(red: 30 / 255, green: 88 / 255, blue: 225 / 255)

    var body: some View {
        HStack(spacing: 20) {
            Button(action: onNext) {
                Image(systemName: "forward.end.fill")
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(buttonColor)
                    .cornerRadius(22)
            }

            Button(action: onPlay) {
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(buttonColor)
                    .cornerRadius(22)
            }

            Button(action: onRepeat) {
                Image(systemName: isRepeating ? "stop.fill" : "repeat")
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(buttonColor)
                    .cornerRadius(22)
            }
        }
    }
}
