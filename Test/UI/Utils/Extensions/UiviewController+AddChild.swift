//
//  UiviewController+AddChild.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 06/05/22.
//

import Foundation
import UIKit
extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height ?? 0.0
   }

    
}

extension UIViewController{
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}


extension UIViewController {
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        let imageView = UIImageView(image: image)
        let titleView = UIStackView(arrangedSubviews: [imageView, titleLbl])
        titleView.axis = .horizontal
        titleView.spacing = 10.0
        navigationItem.titleView = titleView
    }
}
