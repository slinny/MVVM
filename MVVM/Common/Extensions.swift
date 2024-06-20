import Foundation
import UIKit

// MARK: load image for imageView
extension UIImageView {
    func fetchAndSetImage(from url: String) {
        APIManager.shared.fetchData(from: url) { data in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
