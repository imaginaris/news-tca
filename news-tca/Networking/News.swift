import Foundation

protocol GenericResponseType {
    var status: String { get }
    var errorCode: String? { get }
    var errorMessage: String? { get }
}

struct FetchNewsResponse: GenericResponseType, Decodable {
    private enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "code"
        case errorMessage = "message"
        case articles
    }

    let status: String
    let errorCode: String?
    let errorMessage: String?
    let articles: [NewsArticle]?
}

struct NewsArticle: Codable, Equatable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }

    let id: UUID // Used for Identifiable
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decodeIfPresent(UUID.self, forKey: .author)) ?? UUID()
        self.source = try container.decode(Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}
