import Foundation

enum Constants: String {
    case URL = "https://itunes.apple.com/search?term=a"
}

enum APIError: String {
    case invalidURLError = "Invalid URL"
    case fetchDataError = "Error fetching data"
    case decodingError = "Error decoding data"
    case noDataError = "No data received"
}
