//
//  ToastExtansion.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 17/05/22.
//

import Foundation
import UIKit

extension UIViewController{

    func showToast(message: String){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = .black
        toastLabel.numberOfLines=0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustHeight = max (labelHeight, textSize.height + 20)
        
        toastLabel.frame = CGRect(x: 20, y: self.topbarHeight - 30, width: labelWidth + 20, height: adjustHeight)
        toastLabel.center.x = window.center.x
        toastLabel.layer.cornerRadius = 5
        toastLabel.layer.masksToBounds=true
        
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        
        window.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0
        }) { (_) in
            toastLabel.removeFromSuperview()
        }
    }
    
    func showToastForHome(message: String){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textColor = UIColor.white
        toastLabel.backgroundColor = .black
        toastLabel.numberOfLines=0
        
        let textSize = toastLabel.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustHeight = max (labelHeight, textSize.height + 20)
        
        toastLabel.frame = CGRect(x: 20, y: self.topbarHeight*1.2, width: labelWidth + 20, height: adjustHeight)
        toastLabel.center.x = window.center.x
        toastLabel.layer.cornerRadius = 5
        toastLabel.layer.masksToBounds=true
        
        let feedbackGenerator = UISelectionFeedbackGenerator()
        feedbackGenerator.selectionChanged()
        
        window.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0
        }) { (_) in
            toastLabel.removeFromSuperview()
        }
    }
}

