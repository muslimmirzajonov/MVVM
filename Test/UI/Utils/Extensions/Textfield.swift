//
//  Textfield.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//


import Foundation
import UIKit

@propertyWrapper
public class TextField  {
    public var wrappedValue: UITextField

    public init(placeholder: String,size:CGFloat) {
        wrappedValue = UITextField()
        wrappedValue.placeholder = placeholder
        configureLabel(size: size)
    }
    
    
    private func configureLabel(size:CGFloat) {
        wrappedValue.layer.cornerRadius = 5
        wrappedValue.font = UIFont(name: "HelveticaNeue-Light", size: size)
//        wrappedValue.backgroundColor = Colors.White
        wrappedValue.layer.borderColor=UIColor.systemGray.cgColor
        wrappedValue.layer.borderWidth=1
//        wrappedValue.tintColor = UIColor(rgb: 0x313E47)
        wrappedValue.textColor=UIColor(rgb: 0x313E47)
        wrappedValue.text = "".uppercased()
        
        wrappedValue.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: wrappedValue.frame.height))
        wrappedValue.leftViewMode = .always
        wrappedValue.text="".uppercased()
        wrappedValue.returnKeyType = .next
        

        wrappedValue.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: wrappedValue.frame.height))
        wrappedValue.rightViewMode = .always
        wrappedValue.autocapitalizationType = UITextAutocapitalizationType.none
        wrappedValue.addDoneButtonOnKeyboard()
    }

}
