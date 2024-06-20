import Foundation

// MARK: model classes
struct Results: Codable {
    let results: [Result]
}

struct Result: Codable {
    let wrapperType: String
    let artistName: String
    let collectionPrice: Double
    let country: Country
    let primaryGenreName: String
    let artworkUrl60: String
}

enum Country: String, Codable {
    case usa = "USA"
}
