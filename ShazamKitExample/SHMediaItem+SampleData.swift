//
//  Created by Artem Novichkov on 22.02.2025.
//

import ShazamKit

extension SHMediaItem {

    static let sample = SHMediaItem(properties: [.title: "Title",
                                                 .artist: "Artist",
                                                 .artworkURL: URL(string: "https://picsum.photos/200")!,
                                                 .appleMusicURL: URL(string: "https://picsum.photos/200")!])

    var youtubeURL: URL? {
        guard let title else {
            return nil
        }
        return URL(string: "https://www.youtube.com/results?search_query=" + title)
    }

    var spotifyURL: URL? {
        guard let title else {
            return nil
        }
        return URL(string: "https://open.spotify.com/search/" + title)
    }
}
