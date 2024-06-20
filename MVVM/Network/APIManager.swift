import Foundation

class APIManager {
    static let shared = APIManager()
    
    // MARK: fetch data
    func fetchData(from url: String, completion: @escaping (Data) -> () ) {
        guard let serverURL = URL(string: url) else {
            print(APIError.invalidURLError)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: serverURL) ) { data, response, error in
            if error != nil {
                print(APIError.fetchDataError)
                return
            }
            
            guard let data = data else {
                print(APIError.noDataError)
                return
            }
            
            completion(data)
        }.resume()
    }
}
