import Foundation

class ItunesViewModel {
    
    private var records = [Result]()
    
    func fetchData(completion: @escaping () -> ()) {
        ItunesAPIManager.shared.fetchData(ItunesConstants.URL.rawValue) { (data: Results?) in
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
