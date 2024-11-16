//
//  UIView.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//
import UIKit

extension UIView {
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func roundTopCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func roundAllCorners(radius: CGFloat) {
        DispatchQueue.main.async {
            self.roundCorners(corners:[.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radius)
        }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { (aView) in
            aView.removeFromSuperview()
        }
    }
}
