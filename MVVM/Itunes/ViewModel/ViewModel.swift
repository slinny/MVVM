import Foundation

class ViewModel {
    
    private var records = [Result]()
    
    func fetchData(completion: @escaping () -> ()) {
        APIManager.shared.fetchData(from: Constants.URL.rawValue) { (data: Results?) in
            guard let receivdData = data else {
                return
            }
            
            self.records = receivdData.results
            completion()
        }
    }
    
    func getResults() -> [Result] {
        return records
    }
}
