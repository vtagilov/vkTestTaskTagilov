//
//  UILabel.swift
//  vkTestTaskTagilov
//
//  Created by Владимир on 20.03.2024.
//

import UIKit

enum TextSize {
    static let small = 20.0
    static let medium = 24.0
    static let large = 32.0
    static let veryLarge = 64.0
}

extension UILabel {
    static func createLabel(
        text: String = "",
        font: UIFont = .systemFont(ofSize: TextSize.medium),
        textColor: UIColor = .white) -> UILabel {
            let label = UILabel()
            label.font = font
            label.text = text
            label.textColor = textColor
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
}
