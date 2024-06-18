import Foundation
import UIKit

extension UIImageView {
    func fetchAndSetImage(from url: String) {
        APIManager.shared.fetchImage(from: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
