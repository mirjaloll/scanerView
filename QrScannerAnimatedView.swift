//
//  QrScannerAnimatedView.swift
//  ClickEvolution_iOS
//
//  Created by Sirojiddinov Mirjalol on 03/11/21.
//  Copyright © 2021 Click LLC. All rights reserved.
//

import UIKit


class QrScannerAnimatedView: UIView {
    private var animatingLineLayer = CAShapeLayer()
  
    var duration: Double = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var repeatCount: Float = 50.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var color = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    var radius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    var thickness: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    var length: CGFloat = 30 {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override func draw(_ rect: CGRect) {
        color.set()
        
        let t2 = thickness / 2
        let path = UIBezierPath()
        path.move(to: CGPoint(x: t2, y: length + radius + t2))
        path.addLine(to: CGPoint(x: t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: radius + t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: true)
        path.addLine(to: CGPoint(x: length + radius + t2, y: t2))
        
        path.move(to: CGPoint(x: frame.width - t2, y: length + radius + t2))
        path.addLine(to: CGPoint(x: frame.width - t2, y: radius + t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: radius + t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2, y: t2))
        
        path.move(to: CGPoint(x: t2, y: frame.height - length - radius - t2))
        path.addLine(to: CGPoint(x: t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: radius + t2, y: frame.height - radius - t2), radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addLine(to: CGPoint(x: length + radius + t2, y: frame.height - t2))
        
        path.move(to: CGPoint(x: frame.width - t2, y: frame.height - length - radius - t2))
        path.addLine(to: CGPoint(x: frame.width - t2, y: frame.height - radius - t2))
        path.addArc(withCenter: CGPoint(x: frame.width - radius - t2, y: frame.height - radius - t2), radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: frame.width - length - radius - t2, y: frame.height - t2))
        
        path.lineWidth = thickness
        path.stroke()
        animatingLineLayer = getCALayerByPath(from: CGPoint(x: frame.width * 0.1, y: frame.height * 0.2), to: CGPoint(x: frame.width * 0.9, y: frame.height * 0.2))
        layer.addSublayer(animatingLineLayer)
        
    }
    
    // call this in viewDidAppear method
    func animateLine() {
        let position = animatingLineLayer.position
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = animatingLineLayer.position
        print(animatingLineLayer.position)
        animation.toValue = CGPoint(x: position.x, y: position.y + frame.height * 0.6)
        animation.duration = duration
        animation.autoreverses = true
        animation.repeatCount = repeatCount
        animatingLineLayer.position = position
        animatingLineLayer.add(animation, forKey: "animatePosition")
    }
    
    private func getCALayerByPath (from: CGPoint, to: CGPoint) -> CAShapeLayer {
        
        let path = UIBezierPath()
        path.move(to: from)
        path.addLine(to: to)
        
        let curveLayer = CAShapeLayer()
        curveLayer.path = path.cgPath
        curveLayer.fillColor = nil
        curveLayer.strokeColor = color.cgColor
        curveLayer.lineWidth = thickness
        curveLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
        curveLayer.cornerRadius = 1
        return curveLayer
    }
    
   
    
    
    
    
}
