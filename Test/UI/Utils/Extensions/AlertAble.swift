//
//  AlertAble.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//
import UIKit
public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil, handler:((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: completion)
    }
}
