import ComposableArchitecture
import Foundation

struct NewsApiService {

    enum ApiError: Error {
        case errorResponse(String)
    }

    private static let topHeadlinesPath = "top-headlines"
    private static let everythingPath = "everything"
    private static let sourcesPath = "top-headlines/sources"

    var fetchGeneralNews: () async throws -> [NewsArticle]
    var fetchNewsFromSource: (_ sourceID: String) async throws -> [NewsArticle]
    var fetchSources: () async throws -> [Source]

    @Dependency(\.urlSession) static var urlSession

    private static func buildGeneralNewsURL() -> URL! {
        let urlWithPath = Constants.newsApiBaseURL.appendingPathComponent(topHeadlinesPath)
        var components = URLComponents(url: urlWithPath, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            .init(name: "category", value: "general")
        ]
        return components?.url
    }

    private static func buildSourceNewsURL(sourceID: String?) -> URL! {
        let urlWithPath = Constants.newsApiBaseURL.appendingPathComponent(everythingPath)
        var components = URLComponents(url: urlWithPath, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            .init(name: "sources", value: sourceID)
        ]
        return components?.url
    }

    private static func fetchNews(url: URL) async throws -> [NewsArticle] {
        var request = URLRequest(url: url)
        request.addApiKey()
        let (data, _) = try await urlSession.data(for: request)
        let responseData = try JSONDecoder().decode(FetchNewsResponse.self, from: data)
        try parseError(response: responseData)
        return responseData.articles ?? []
    }

    private static func fetchSources() async throws -> [Source] {
        var request = URLRequest(url: Constants.newsApiBaseURL.appendingPathComponent(sourcesPath))
        request.addApiKey()
        let (data, _) = try await urlSession.data(for: request)
        let responseData = try JSONDecoder().decode(SourcesResponse.self, from: data)
        try parseError(response: responseData)
        return responseData.sources ?? []
    }

    private static func parseError(response: GenericResponseType) throws -> Void {
        guard response.status == "error",
              let errorMessage = response.errorMessage else {
            return
        }
        throw ApiError.errorResponse("\(errorMessage) (\(response.errorCode ?? "")")
    }
}

extension NewsApiService: DependencyKey {
    static let liveValue = Self(
        fetchGeneralNews: {
            try await fetchNews(url: buildGeneralNewsURL())
        }, fetchNewsFromSource: { sourceID in
            try await fetchNews(url: buildSourceNewsURL(sourceID: sourceID))
        }, fetchSources: {
            try await fetchSources()
        }
    )
}

extension DependencyValues {
    var apiService: NewsApiService {
        get { self[NewsApiService.self] }
        set { self[NewsApiService.self] = newValue }
    }
}

private extension URLRequest {
    mutating func addApiKey() {
        addValue(Constants.Keys.newsApiKey, forHTTPHeaderField: "X-Api-Key")
    }
}
