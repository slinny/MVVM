import Foundation

// MARK: constants
enum Constants: String {
    case baseURL = "https://itunes.apple.com/"
}

// MARK: error messsages
enum APIError: String {
    case invalidURLError = "Invalid URL"
    case fetchDataError = "Error fetching data"
    case decodingError = "Error decoding data"
    case noDataError = "No data received"
}
