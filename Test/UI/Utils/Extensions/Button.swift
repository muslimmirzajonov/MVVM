//
//  Button.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import UIKit
@propertyWrapper
public class MainButton {
    public var wrappedValue:UIButton

    public init(title: String,radius:CGFloat) {
        self.wrappedValue = UIButton()
        wrappedValue.setTitle(title, for: .normal)
        configureLabel(radius: radius)
    }

    private func configureLabel(radius:CGFloat) {
        wrappedValue.backgroundColor = Colors.LoginButtonLabelColor
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.title(for: .normal)
    }
    
}

@propertyWrapper
public class MainButtonAnchor {
    public var wrappedValue:UIButton

    public init(title: String,radius:CGFloat) {
        self.wrappedValue = UIButton()
        wrappedValue.setTitle(title, for: .normal)
        configureLabel(radius: radius)
    }

    private func configureLabel(radius:CGFloat) {
        wrappedValue.backgroundColor = Colors.LoginButtonLabelColor
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.title(for: .normal)
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


@propertyWrapper
public class LabelBtn {
    public var wrappedValue:UIButton

    public init(title: String,titleColor:UIColor) {
        self.wrappedValue = UIButton()
        wrappedValue.setTitle(title, for: .normal)
        configureLabel(titleColor: titleColor)
        
    }

    private func configureLabel(titleColor:UIColor) {
        wrappedValue.setTitleColor(titleColor, for: .normal)
    }
    
}
