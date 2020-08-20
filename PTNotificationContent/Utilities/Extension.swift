//
//  Extension.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 14/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIColor {
    var imageRepresentation : UIImage {
      let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
      UIGraphicsBeginImageContext(rect.size)
      let context = UIGraphicsGetCurrentContext()

      context?.setFillColor(self.cgColor)
      context?.fill(rect)

      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

    return image!
  }
}

