import UIKit

class ItunesViewController: UIViewController {
    
    @IBOutlet weak var ituneTable: UITableView!
    private var records = [Result]()
    private var viewModel = ItunesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        fetchData()
    }
}


extension ItunesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ituneTable.dequeueReusableCell(withIdentifier: "ItunesTableViewCell") as? ItunesTableViewCell else { return ItunesTableViewCell() }
        cell.updateRecord(records[indexPath.row])
        return cell
    }
}

extension ItunesViewController {
    fileprivate func setupTable() {
        ituneTable.dataSource = self
        ituneTable.register(UINib(nibName: "ItunesTableViewCell", bundle: nil), forCellReuseIdentifier: "ItunesTableViewCell")
    }
    
    fileprivate func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.records = self.viewModel.getResults()
                self.ituneTable.reloadData()
            }
        }
    }
}
