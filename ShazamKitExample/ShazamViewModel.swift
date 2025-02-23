//
//  Created by Artem Novichkov on 22.02.2025.
//

import ShazamKit

@MainActor
final class ShazamViewModel: ObservableObject {

    @Published var managedSession: SHManagedSession = .init()
    @Published var library: SHLibrary = .default
    @Published var errorDescription: String?

    init() {
//        Task { @MainActor in
//            await managedSession.prepare()
//        }
    }

    func match() async {
        let result = await managedSession.result()
        managedSession.cancel()
        switch result {
        case .match(let match):
            if let mediaItem = match.mediaItems.first {
                try? await library.addItems([mediaItem])
            }
        case .noMatch(_):
            print("Mo match")
        case .error(let error, _):
            print(error.localizedDescription)
        }
    }

    func remove(_ mediaItem: SHMediaItem) {
        Task { @MainActor in
            try? await library.removeItems([mediaItem])
        }
    }
}
