//
//  Created by Artem Novichkov on 22.02.2025.
//
import SwiftUI

struct ShazamView: View {

    @StateObject private var viewModel: ShazamViewModel = .init()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.library.items) { mediaItem in
                        MediaItemView(mediaItem: mediaItem) {
                            viewModel.remove(mediaItem)
                        }
                    }
                }
                Text("\(viewModel.managedSession.state)")
                shazamButton
            }
            .navigationTitle("Songs")
            .animation(.default, value: viewModel.library.items)
            .alert(item: $viewModel.errorDescription) { errorDescription in
                Alert(title: Text("Error"), message: Text(errorDescription))
            }
        }
    }

    // MARK: - Private

    private var shazamButton: some View {
        Button(action: match) {
            Image(systemName: "shazam.logo.fill")
                .resizable()
                .frame(width: 52, height: 52)
                .symbolEffect(.pulse, isActive: viewModel.managedSession.state == .matching)
        }
        .allowsHitTesting(viewModel.managedSession.state != .matching)
    }

    private func match() {
        Task {
            await viewModel.match()
        }
    }
}

extension String: @retroactive Identifiable {

    public var id: String { self }
}

#Preview {
    ShazamView()
}
