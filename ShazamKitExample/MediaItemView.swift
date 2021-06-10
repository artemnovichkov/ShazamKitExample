//
//  Created by Artem Novichkov on 10.06.2021.
//

import SwiftUI
import ShazamKit

struct MediaItemView: View {

    @State var mediaItem: SHMatchedMediaItem

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                image(with: proxy)
                infoView
                Spacer()
            }
        }
        .padding()
    }

    @ViewBuilder
    private var infoView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mediaItem.title ?? "Unknown track")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                Text(mediaItem.artist ?? "Unknown artist")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            Spacer()
            addButton
        }
    }

    @ViewBuilder
    private var addButton: some View {
        Button(action: add) {
            Image(systemName: "plus")
                .imageScale(.large)
                .symbolVariant(.circle)
        }
    }

    @ViewBuilder
    private func image(with proxy: GeometryProxy) -> some View {
        AsyncImage(url: mediaItem.artworkURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "photo")
                .imageScale(.large)
                .frame(width: proxy.size.width,
                       height: proxy.size.width,
                       alignment: .center)
                .background(Color(UIColor.secondarySystemBackground))

        }
        .cornerRadius(10)
    }

    private func add() {
        SHMediaLibrary.default.add([mediaItem]) { error in
            print(error ?? "Added successfully")
        }
    }
}
