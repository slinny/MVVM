import UIKit

class ItunesViewController: UIViewController {
    
    @IBOutlet weak var ituneTable: UITableView!
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        fetchData()
    }
}

extension ItunesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ituneTable.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return TableViewCell() }
        cell.updateRecord(viewModel.getData()[indexPath.row])
        return cell
    }
}

extension ItunesViewController {
    fileprivate func setupTable() {
        ituneTable.dataSource = self
        ituneTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    fileprivate func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.ituneTable.reloadData()
            }
        }
    }
}
