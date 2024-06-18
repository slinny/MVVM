import Foundation

class ViewModel {
    
    private var todos = [Todo]()
    
    func fetchData(completion: @escaping(() -> ())) {
        APIManager.shared.fetchData(Constants.url) { data in
            guard let receivedData = data else {
                print("no data received")
                return
            }
            
            print("data received")
            
            if let apiResponse = try? JSONDecoder().decode([Todo].self, from: receivedData) {
                print("data decoded")
                self.todos = apiResponse
            } else {
                print("data could not be decoded")
            }
            completion()
        }
    }
    
    func getData() -> [Todo] {
        return todos
    }
}
