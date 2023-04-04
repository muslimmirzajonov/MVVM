//
//  Labels.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 06/05/22.
//

import Foundation
import UIKit
@propertyWrapper
public class MainLabel {
    public var wrappedValue: UILabel

    public init(text: String, size:Int, weight:UIFont.Weight, color:UIColor) {
        self.wrappedValue = UILabel()
        wrappedValue.text = text
        configureLabel(ofSize: size, weight: weight, color: color)
    }

    private func configureLabel(ofSize:Int, weight:UIFont.Weight, color:UIColor) {
        wrappedValue.textColor = color
        wrappedValue.font = .systemFont(ofSize: CGFloat(ofSize), weight: weight)
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.textAlignment = .center
//        wrappedValue.sizeToFit()
    }
}

@propertyWrapper
public class ErrorLabel {
    public var wrappedValue: UILabel

    public init(text: String) {
        self.wrappedValue = UILabel()
        wrappedValue.text = text
        configureLabel()
    }

    private func configureLabel() {
        wrappedValue.textColor = .lightGray
        wrappedValue.font = .systemFont(ofSize: 28, weight: .regular)
        wrappedValue.sizeToFit()
    }
}
