//
//  File.swift
//  KudenetShared
//
//  Created by Kuutti Taavitsainen on 31.7.2025.
//

import Foundation
import UIKit

extension UIImage {
    public func resize(size: CGSize) -> UIImage? {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1.0
        format.opaque = false
        
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
