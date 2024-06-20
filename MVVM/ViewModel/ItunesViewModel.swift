import Foundation

class ItunesViewModel {
    
    private var records = [Result]()
    
    func fetchData(from urlString: String, completion: @escaping () -> ()) {
        APIManager.shared.fetchData(from: urlString) { (data: Results?) in
            guard let receivdData = data else {
                return
            }
            
            self.records = receivdData.results
            completion()
        }
    }
    
    func getData() -> [Result] {
        return records
    }
    
    func clearData() {
        records = []
    }
}
