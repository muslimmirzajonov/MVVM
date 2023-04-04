//
//  ViewExtansions.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


extension UIView{
    //MARK: TOP and Bottom
    func topOfTop(view:UIView, const:CGFloat) {
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: const).isActive=true
    }
    func topOfBottom(view:UIView, const:CGFloat) {
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: const).isActive=true
    }
    
    func bottomOfTop(view:UIView, const:CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: const).isActive=true
    }
    func bottomOfBottom(view:UIView, const:CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: const).isActive=true
    }
    
    
    
    
    //MARK: LEFT and RIGHT
    func leftOfLeft(view:UIView, const:CGFloat) {
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: const).isActive=true
    }
    func leftOfRight(view:UIView, const:CGFloat) {
        self.leftAnchor.constraint(equalTo: view.rightAnchor, constant: const).isActive=true
    }
    func rightOfRight(view:UIView, const:CGFloat) {
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: const).isActive=true
    }
    
    func rightOfLeft(view:UIView, const:CGFloat) {
        self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: const).isActive=true
    }
    
    //MARK: WIDTH and HEIGHT
    func width(const:CGFloat) {
        self.widthAnchor.constraint(equalToConstant: const).isActive=true
    }
    
    func height(const:CGFloat) {
        self.heightAnchor.constraint(equalToConstant: const).isActive=true
    }
    
    
    //MARK: CENTERS
    func centerX(view:UIView, const:CGFloat) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: const).isActive=true
    }
    func centerY(view:UIView, const:CGFloat) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: const).isActive=true
    }

//    MARK: - LEFT CENTER.X,Y RIGHT CENTER.Y,X

    func leftForCenterX(view: UIView, const:CGFloat){
        self.leftAnchor.constraint(equalTo: view.centerXAnchor,constant: const).isActive = true
    }
    func rightForCenterX(view : UIView, const: CGFloat){
        self.rightAnchor.constraint(equalTo: view.centerXAnchor,constant: const).isActive = true
    }

    
    public func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)

        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let centerConstraint = centerYAnchor.constraint(equalTo: border.centerYAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)


        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])

        }
    }
    

    
    func addDashedBorder(strokeColor: UIColor, lineWidth: CGFloat) {
        self.layoutIfNeeded()
        let strokeColor = strokeColor.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,6]
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: shapeRect.width, height: shapeRect.height), cornerRadius: self.layer.cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
    }
    
    func DashedBorder(strokeColor: UIColor, lineWidth: CGFloat) {
        self.layoutIfNeeded()
        let strokeColor = strokeColor.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/1, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: shapeRect.width, height: shapeRect.height), cornerRadius: self.layer.cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
    }
}

public enum BorderSide {
    case top, bottom, left, right
}

extension UIView {
    /**
    Get Set x Position
    
    - parameter x: CGFloat
    */
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
    Get Set y Position
    
    - parameter y: CGFloat
    */
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
    Get Set Height
    
    - parameter height: CGFloat
    */
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
    Get Set Width
    
    - parameter width: CGFloat
    */
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
}


extension UIView {

  func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
      self.layer.maskedCorners = corners
      self.layer.cornerRadius = radius
      self.layer.borderWidth = borderWidth
      self.layer.borderColor = borderColor.cgColor
   
  }

}


class DriverAppView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DriverAppButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProgressView: UIProgressView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.progressTintColor = UIColor(rgb: 0x5ED1B6)
        self.trackTintColor = UIColor(rgb: 0xE6E6E6)
        self.layer.cornerRadius = 6.5
        self.translatesAutoresizingMaskIntoConstraints=false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DriverAppTextfield: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: 165, height: 0)
        self.font = .systemFont(ofSize: 16)
        self.text = "Jan 21, 1999"
    }
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
