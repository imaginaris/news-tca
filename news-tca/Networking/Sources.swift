import Foundation

struct SourcesResponse: GenericResponseType, Decodable {
    private enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "code"
        case errorMessage = "message"
        case sources
    }

    let status: String
    let errorCode: String?
    let errorMessage: String?
    let sources: [Source]?
}

struct Source: Codable, Equatable, Identifiable {
    let id: String?
    let name: String
    let description: String?
    let url: String?
}
