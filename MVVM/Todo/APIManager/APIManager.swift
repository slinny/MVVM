import Foundation

class APIManager {
    static let shared = APIManager()
    
    func fetchData(_ urlString:String, _ completion: @escaping((Data?) -> ())) {
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
            completion(data)
        }.resume()
    }
}
