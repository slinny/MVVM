import UIKit

// MARK: main screen
class ItunesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ituneTable: UITableView!
    var ituneViewModel = ItunesViewModel()
    
    private var endpoint = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchbar()
        setupTable()
    }
}

// MARK: update tableview data
extension ItunesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ituneViewModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ituneTable.dequeueReusableCell(withIdentifier: "ItunesTableViewCell") as? ItunesTableViewCell else { return ItunesTableViewCell() }
        cell.updateRecord(ituneViewModel.getData()[indexPath.row])
        return cell
    }
}

// MARK: setup view, fetch data and update data
extension ItunesViewController {
    fileprivate func setupSearchbar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        searchBar.autocapitalizationType = .none
        searchBar.enablesReturnKeyAutomatically = false
    }
    
    fileprivate func setupTable() {
        ituneTable.dataSource = self
        ituneTable.register(UINib(nibName: "ItunesTableViewCell", bundle: nil), forCellReuseIdentifier: "ItunesTableViewCell")
    }
    
    func fetchData() {
        ituneViewModel.fetchData(from: Constants.baseURL.rawValue + endpoint) {
            DispatchQueue.main.async {
                self.ituneTable.reloadData()
            }
        }
    }
}

// MARK: fetch data based on searchbar input
extension ItunesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let input = searchBar.text, !input.isEmpty else {
            ituneViewModel.clearData()
            self.ituneTable.reloadData()
            return
        }
        
        endpoint = "search?term=" + input.lowercased()
        fetchData()
    }
}
