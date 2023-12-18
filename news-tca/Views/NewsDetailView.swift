import SwiftUI
import ComposableArchitecture

struct NewsDetailView: View {
    let store: StoreOf<NewsDetailReducer>

    @State private var isErrorPresented = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            let article = viewStore.article
            ScrollView([.vertical]) {
                VStack(spacing: 8.0) {
                    Text(article.title)
                        .font(.title)
                    if let urlString = article.urlToImage,
                        let imageURL = URL(string: urlString) {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 150)
                    }
                    VStack(alignment: .leading) {
                        if let author = article.author {
                            Text("By: \(author)")
                                .font(.headline)
                        }
                        if let date = Helpers.formatDateFromServer(article.publishedAt) {
                            Text(date)
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    if let content = article.content {
                        Text(content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    if let articleURL = URL(string: article.url) {
                        Spacer()
                        Link("Open in browser", destination: articleURL)
                    }
                }
            }
        }
        .onAppear(perform: {
            store.send(.viewDidAppear)
        })
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}
