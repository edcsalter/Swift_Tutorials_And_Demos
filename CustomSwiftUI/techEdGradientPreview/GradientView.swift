//
//  GradientView.swift
//  CustomSwiftUI
//
//  Created by Edward Salter on 9/19/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.whiteColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.blackColor() {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var roundness: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    //MARK: Overrides
    override class func layerClass()->AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: Framework Funcs
    private func setupView() {
        let colors:Array<AnyObject> = [startColor.CGColor, endColor.CGColor]
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = roundness
        gradientLayer.startPoint = CGPoint(x:0, y:0)
        if (isHorizontal) {
            gradientLayer.endPoint = CGPoint(x:1, y:0)
        }else{
            gradientLayer.endPoint = CGPoint(x:0, y:1)
        }
    self.setNeedsDisplay()
    }
    
    //MARK: Main Layer = CAGradientLayer
    var gradientLayer: CAGradientLayer {
        return layer as CAGradientLayer
    }
}
