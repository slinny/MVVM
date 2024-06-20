import Foundation
import UIKit

// MARK: load image for imageView
extension UIImageView {
    func fetchAndSetImage(from url: String) {
        APIManager.shared.fetchImage(from: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
