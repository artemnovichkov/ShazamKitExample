//
//  Created by Artem Novichkov on 10.06.2021.
//

import SwiftUI
import ShazamKit

extension SHMatchedMediaItem: Identifiable {
    
    public var id: String {
        shazamID ?? ""
    }
}

struct ShazamView: View {

    @StateObject private var viewModel: ShazamViewModel = .init()

    var body: some View {
        content
            .sheet(item: $viewModel.mediaItem) { mediaItem in
                MediaItemView(mediaItem: mediaItem)
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? ""))
            }
    }

    @ViewBuilder
    var content: some View {
        if viewModel.matching {
            ProgressView("Matching...")
        }
        else {
            VStack(spacing: 32) {
                Image("shazamkit")
                Button(action: shazam) {
                    Text("Shazam")
                        .padding()
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
    }

    func shazam() {
        viewModel.start()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShazamView()
    }
}
