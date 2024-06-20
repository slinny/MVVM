import UIKit

class ItunesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumPic: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumDes: UILabel!
    @IBOutlet weak var albumPrice: UILabel!
    @IBOutlet weak var albumStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        albumStack.spacing = 0
        addBorderToImageView()
        customizePriceLabel()
    }
}

extension ItunesTableViewCell {
    // MARK: configure cell data
    func configureItunesCell(record: Result) {
        albumPic.fetchAndSetImage(from: record.artworkUrl60)
        albumTitle.text = record.primaryGenreName
        albumDes.text = "\(record.artistName) - \(record.primaryGenreName) - \(record.wrapperType)"
        albumPrice.text = "   $\(record.collectionPrice)"
    }
    
    // MARK: add border to imageView
    fileprivate func addBorderToImageView() {
        albumPic.layer.borderWidth = 0.5
        albumPic.layer.borderColor = UIColor.systemGray.cgColor
        albumPic.clipsToBounds = true
    }
    
    // MARK: customize label
    fileprivate func customizePriceLabel() {
        albumPrice.layer.borderWidth = 1.0
        albumPrice.layer.borderColor = UIColor.systemBlue.cgColor
        albumPrice.layer.cornerRadius = 5.0
        albumPrice.clipsToBounds = true
    }
}
