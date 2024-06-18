import UIKit

class ItunesTableViewCell: UITableViewCell {

    @IBOutlet weak var albumPic: UIImageView!
    @IBOutlet weak var albumDes: UILabel!
    @IBOutlet weak var albumPrice: UILabel!
    
    private var record: Result?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizePriceLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ItunesTableViewCell {
    func updateRecord(_ record: Result) {
        self.record = record
        updateData()
    }
    
    func updateData() {
        if let record = record {
            loadImageFromUrl(urlString: record.artworkUrl60) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.albumPic.image = image
                    } else {
                        
                    }
                }
            }
            
            albumDes.text = "\(record.primaryGenreName) \n\(record.artistName) - \(record.primaryGenreName) - \(record.wrapperType)"
            
            albumPrice.text = "  $\(record.collectionPrice)"
        }
    }
    
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    fileprivate func customizePriceLabel() {
        albumPrice.layer.borderWidth = 1.0
        albumPrice.layer.borderColor = UIColor.systemBlue.cgColor
        albumPrice.layer.cornerRadius = 5.0
        albumPrice.clipsToBounds = true
    }
}
