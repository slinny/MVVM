import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumPic: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumDes: UILabel!
    @IBOutlet weak var albumPrice: UILabel!
    
    var record: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addBorderToImageView()
        customizePriceLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TableViewCell {
    func updateRecord(_ record: Result) {
        self.record = record
        updateData()
    }
    
    func updateData() {
        if let record = record {
            albumPic.fetchAndSetImage(from: record.artworkUrl60)
            albumTitle.text = record.primaryGenreName
            albumDes.text = "\(record.artistName) - \(record.primaryGenreName) - \(record.wrapperType)"
            albumPrice.text = "   $\(record.collectionPrice)"
        }
    }
    
    fileprivate func addBorderToImageView() {
        albumPic.layer.borderWidth = 0.5
        albumPic.layer.borderColor = UIColor.systemGray.cgColor
        albumPic.clipsToBounds = true
    }
    
    fileprivate func customizePriceLabel() {
        albumPrice.layer.borderWidth = 1.0
        albumPrice.layer.borderColor = UIColor.systemBlue.cgColor
        albumPrice.layer.cornerRadius = 5.0
        albumPrice.clipsToBounds = true
    }
}
