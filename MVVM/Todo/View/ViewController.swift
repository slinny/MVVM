import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTable: UITableView!
    let viewModel = ViewModel()
    private var todos = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        fetchData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as? TodoTableViewCell else { return TodoTableViewCell() }
        cell.setTodo(todos[indexPath.row])
        return cell
    }
}

extension ViewController {
    fileprivate func setupTable() {
        todoTable.dataSource = self
        todoTable.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    fileprivate func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.todos = self.viewModel.getData()
                self.todoTable.reloadData()
            }
        }
    }
}
