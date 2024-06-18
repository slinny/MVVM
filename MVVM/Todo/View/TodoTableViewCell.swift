import UIKit

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    private var todo: Todo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TodoTableViewCell {
    func updateCell() {
        if let todo = todo {
            userIdLabel.text = "userId: \(todo.userId)"
            idLabel.text = "id: \(todo.id)"
            titleLabel.text = "title: \(todo.title)"
            completedLabel.text = "userId: \(todo.completed)"
        }
    }
    
    func setTodo(_ todo: Todo) {
        self.todo = todo
        updateCell()
    }
}
