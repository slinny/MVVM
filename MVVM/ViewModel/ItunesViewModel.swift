import Foundation

class ItunesViewModel {
    
    private var records = [Result]()
    
    func fetchData(from urlString: String, completion: @escaping () -> ()) {
        APIManager.shared.fetchData(from: urlString) { data in
            if let apiResponse = try? JSONDecoder().decode(Results.self, from: data) {
                self.records = apiResponse.results
                completion()
            }
        }
    }
    
    func getData() -> [Result] {
        return records
    }
    
    func clearData() {
        records = []
    }
}
