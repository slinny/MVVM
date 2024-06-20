import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()
    
    // MARK: fetch data
    func fetchData<T: Codable>(from url: String, closure: @escaping ((T?) -> ()) ) {
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
            
            if let apiResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    closure(apiResponse)
                }
            }
        }.resume()
    }
    
    // MARK: fetch image
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            print(APIError.invalidURLError)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if error != nil {
                print(APIError.fetchDataError)
                return
            }
            
            guard let data = data else {
                print(APIError.noDataError)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
