import Foundation

class ItunesAPIManager {
    static let shared = ItunesAPIManager()
    
    func fetchData<T: Decodable>(_ urlString:String, _ completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        print("valid url")
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print("urlsession error: \(error.localizedDescription)")
                return
            }
            
            print("urlsession success")
            guard let receivedData = data else { return }
            guard let apiResponse = try? JSONDecoder().decode(T.self, from: receivedData) else {
                return
            }
            
            completion(apiResponse)
        }.resume()
    }
    
}
