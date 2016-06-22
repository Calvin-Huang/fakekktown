//
//  UICircleProgressView.swift
//  FakeKKTown
//
//  Created by Calvin on 6/20/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import UIKit

class UICircleProgressView: UIView {
    
    // Default rim color: #BBDEFB
    var rimColor = UIColor(red: 187/255.0, green: 222/255.0, blue: 251/255.0, alpha: 1) {
        didSet {
            rimLayer.strokeColor = rimColor.CGColor
        }
    }
    
    // Default bar color: #2196F3
    var barColor = UIColor(red: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1)
    
    // Default text color: #2F7DB7
    var textColor = UIColor(red: 47/255.0, green: 125/255.0, blue: 183/255.0, alpha: 1) {
        didSet {
            progressTextLabel.textColor = textColor
        }
    }
    
    var fillColor = UIColor.clearColor()
    var maskColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
    var progress: CGFloat {
        set {
            if newValue > 1 {
                progressBar.strokeEnd = 1
            } else if newValue < 0 {
                progressBar.strokeEnd = 0
            } else {
                progressBar.strokeEnd = newValue
            }
        }
        
        get {
            return progressBar.strokeEnd
        }
    }
    
    let progressTextLabel = UILabel()
    
    let progressBar = CAShapeLayer()
    let rimLayer = CAShapeLayer()
    
    var scaleRate: CGFloat {
        get {
            return self.bounds.width / 168
        }
    }
    
    private lazy var maskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = self.maskColor.CGColor
        
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpUI()
    }
    
    func showInView(parentView: UIView, withMask: Bool = true) {
        if withMask {
            maskLayer.frame = parentView.bounds
            parentView.layer.addSublayer(maskLayer)
        }
        
        parentView.addSubview(self)
    }
    
    func hide() {
        maskLayer.removeFromSuperlayer()
        self.removeFromSuperview()
    }
    
    // MARK: - Private Methods
    private func setUpUI() {
        // Make frame fit to NSLayoutConstraint
        self.layoutIfNeeded()
        
        progressTextLabel.frame = self.bounds
        progressTextLabel.font = UIFont.systemFontOfSize(72 * scaleRate, weight: UIFontWeightMedium)
        progressTextLabel.text = "\(42)"
        progressTextLabel.textColor = textColor
        progressTextLabel.textAlignment = .Center
        
        self.addSubview(progressTextLabel)
        
        rimLayer.frame = self.bounds
        rimLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0.5 * min(self.bounds.width, self.bounds.height)).CGPath
        rimLayer.strokeColor = rimColor.CGColor
        rimLayer.fillColor = nil
        rimLayer.lineWidth = 20 * scaleRate
        
        progressBar.frame = self.bounds
        progressBar.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 0.5 * min(self.bounds.width, self.bounds.height)).CGPath
        progressBar.strokeColor = barColor.CGColor
        progressBar.fillColor = UIColor.clearColor().CGColor
        progressBar.lineWidth = 20 * scaleRate
        progress = 0
        
        self.layer.addSublayer(rimLayer)
        self.layer.addSublayer(progressBar)
    }
}
