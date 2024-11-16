//
//  UImageView.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        // Set placeholder image
        self.image = placeholder
        
        // Check cached image
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        // Download the image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            // Cache the image
            ImageCache.shared.setImage(image, forKey: url.absoluteString)
            
            // Set the image on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
