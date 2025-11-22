
import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let isLoading: Bool
    let action: () -> Void

    public init(
        title: String,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        Button(action: {
            guard !isLoading else { return }
            action()
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                }

                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
        .buttonStyle(.borderedProminent)
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .disabled(isLoading)
    }
}


#if DEBUG
import SwiftUI

#Preview {
    PrimaryButton(title: "Primary Button") { }
}
#endif
