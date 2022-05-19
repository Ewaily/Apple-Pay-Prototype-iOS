//
//  UIView+Extensions.swift
//  Fan World
//
//  Created by Ahmad Ragab on 23/03/2022.
//

import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parentViewController
        } else {
            return nil
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue
            clipsToBounds = true }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    func loadViewFromNib() {
        guard let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?[0] as? UIView else {
            return
        }
        self.addSubview(view)
        view.frame = bounds
    }
    
    func showLoadingIndicator(color: UIColor = .white) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeAllActivityIndicators()
            let sideLength = min(self.frame.width, self.frame.height)
            let loadingIndicatorFrame = CGRect(x: 0.0, y: 0.0, width: sideLength, height: sideLength)
            let activityIndicatorView = UIActivityIndicatorView(frame: loadingIndicatorFrame)
            activityIndicatorView.color = color
            activityIndicatorView.center = self.convert(self.center, from: self.superview)
            self.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimating()
            self.isUserInteractionEnabled = false
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeAllActivityIndicators()
            self.isUserInteractionEnabled = true
        }
    }
    
    private func removeAllActivityIndicators() {
        self.subviews.forEach { view in
            if view is UIActivityIndicatorView {
                (view as? UIActivityIndicatorView)?.stopAnimating()
                view.removeFromSuperview()
            }
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = UIScreen.main.bounds
        blurredEffectView.alpha = 0.88
        self.addSubview(blurredEffectView)
    }
    
    func roundCorners(corners: UIRectCorner = [.allCorners], radius: CGFloat = 6) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
