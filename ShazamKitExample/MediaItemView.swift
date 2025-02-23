//
//  Created by Artem Novichkov on 22.02.2025.
//

import SwiftUI
import ShazamKit

struct MediaItemView: View {

    let mediaItem: SHMediaItem
    let removeAction: () -> Void
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack {
            AsyncImage(url: mediaItem.artworkURL) { image in
                image.resizable()
            } placeholder: {
                Color.secondary
            }
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(mediaItem.title ?? "Unknown track")
                    .font(.headline)
                Text(mediaItem.artist ?? "Unknown artist")
                    .font(.body)
                if let creationDate = mediaItem.creationDate {
                    Text(creationDate.formatted())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .contextMenu {
            Section("Listen on:") {
                if let appleMusicURL = mediaItem.appleMusicURL {
                    Button { openURL(appleMusicURL) } label: {
                        Label("Apple Music", systemImage: "arrow.up.right")
                    }
                }
                if let spotifyURL = mediaItem.spotifyURL {
                    Button { openURL(spotifyURL) } label: {
                        Label("Spotify", systemImage: "arrow.up.right")
                    }
                }
                if let youtubeURL = mediaItem.youtubeURL {
                    Button { openURL(youtubeURL) } label: {
                        Label("Youtube", systemImage: "arrow.up.right")
                    }
                }
            }
            Button(role: .destructive) {
                removeAction()
            }
            label: {
                Label("Remove from My Music", systemImage: "trash")
            }
            if let webURL = mediaItem.webURL {
                Divider()
                Button { openURL(webURL) } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview {
    MediaItemView(mediaItem: .sample, removeAction: {})
}
