import SwiftUI

struct NewsCellView: View {
    let article: NewsArticle

    var body: some View {
        HStack {
            if let urlString = article.urlToImage,
                let imageURL = URL(string: urlString) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
            }
            VStack(spacing: 8.0) {
                Text(article.title)
                Text(article.source.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
