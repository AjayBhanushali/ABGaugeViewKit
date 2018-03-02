//
//  ABGaugeView.swift
//  ABGaugeViewKit
//
//  Created by Ajay Bhanushali on 02/03/18.
//  Copyright © 2018 Aimpact. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class ABGaugeView: UIView {
    
    // MARK:- @IBInspectable
    @IBInspectable public var firstColor: UIColor = UIColor(red: 0/255.0, green: 146/255.0, blue: 69/255.0, alpha: 1.0)
    @IBInspectable public var secondColor: UIColor = UIColor(red: 239/255.0, green: 175/255.0, blue: 17/255.0, alpha: 1.0)
    @IBInspectable public var thirdColor: UIColor = UIColor(red: 219/255.0, green: 11/255.0, blue: 11/255.0, alpha: 1.0)
    
    @IBInspectable public var firstArea: CGFloat = 40.0
    @IBInspectable public var secondArea: CGFloat = 30.0
    
    @IBInspectable public var needleColor: UIColor = UIColor(red: 18/255.0, green: 112/255.0, blue: 178/255.0, alpha: 1.0)
    @IBInspectable public var needleValue: CGFloat = 00 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var circleColor: UIColor = UIColor.black
    
    // MARK:- Properties
    var firstAngle: CGFloat!
    var secondAngle: CGFloat!
    var thirdAngle: CGFloat!
    var lastAngle: CGFloat!
    
    // MARK:- UIView Draw method
    override public func draw(_ rect: CGRect) {
        drawGauge()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        drawGauge()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawGauge()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        drawGauge()
    }
    // MARK:- Custom Methods
    
    func drawGauge() {
        layer.sublayers = []
        drawArc()
        drawNeedle()
        drawNeedleCircle()
    }
    /// Draws three arcs
    func drawArc() {
        // 1. Set angles and center values
        firstAngle = 5 * .pi / 6
        lastAngle = .pi / 6
        secondAngle = firstAngle + radian(for: firstArea)
        thirdAngle = secondAngle + radian(for: secondArea)
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 2. Creates arrays of properties in first, third, second order
        let arcs = [ArcModel(startAngle: firstAngle, endAngle: lastAngle, strokeColor: UIColor.lightGray.withAlphaComponent(0.15), arcCap: CGLineCap.round, center:CGPoint(x: bounds.width / 2, y: (bounds.height / 2)+5)),
                    ArcModel(startAngle: firstAngle, endAngle: secondAngle, strokeColor: firstColor, arcCap: CGLineCap.round, center:center),
                    ArcModel(startAngle: thirdAngle, endAngle: lastAngle, strokeColor: thirdColor, arcCap: CGLineCap.round, center:center),
                    ArcModel(startAngle: secondAngle, endAngle: thirdAngle, strokeColor: secondColor, arcCap: CGLineCap.butt, center:center)]
        
        // 3. Creates arc
        for i in 0..<arcs.count {
            createArcWith(startAngle: arcs[i].startAngle, endAngle: arcs[i].endAngle, arcCap: arcs[i].arcCap, strokeColor: arcs[i].strokeColor, center: arcs[i].center)
        }
    }
    
    func createArcWith(startAngle: CGFloat, endAngle: CGFloat, arcCap: CGLineCap, strokeColor: UIColor, center:CGPoint) {
        // 1
        let center = center
        let radius: CGFloat = max(bounds.width, bounds.height)/2 - self.frame.width/20
        let lineWidth: CGFloat = self.frame.width/10
        // 2
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        // 3
        path.lineWidth = lineWidth
        path.lineCapStyle = arcCap
        strokeColor.setStroke()
        path.stroke()
    }
    
    func drawNeedleCircle() {
        // 1
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: self.bounds.width/20, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        // 2
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = circleColor.cgColor
        layer.addSublayer(circleLayer)
    }
    
    func drawNeedle() {
        // 1
        let triangleLayer = CAShapeLayer()
        let shadowLayer = CAShapeLayer()
        
        // 2
        triangleLayer.frame = bounds
        shadowLayer.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y + 5, width: bounds.width, height: bounds.height)
        
        // 3
        let needlePath = UIBezierPath()
        needlePath.move(to: CGPoint(x: self.bounds.width * 0.12, y: self.bounds.width * 0.72))
        needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.565, y: self.bounds.width * 0.42))
        needlePath.addLine(to: CGPoint(x: self.bounds.width * 0.6, y: self.bounds.width * 0.48))
        needlePath.close()
        
        // 4
        triangleLayer.path = needlePath.cgPath
        shadowLayer.path = needlePath.cgPath
        
        // 5
        triangleLayer.fillColor = needleColor.cgColor
        triangleLayer.strokeColor = needleColor.cgColor
        shadowLayer.fillColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        
        // 6
        layer.addSublayer(shadowLayer)
        layer.addSublayer(triangleLayer)
        
        animate(triangleLayer: triangleLayer, shadowLayer: shadowLayer, fromValue: 0, toValue: needleValue+10, duration: 0.5) {
            self.animate(triangleLayer: triangleLayer, shadowLayer: shadowLayer, fromValue: self.needleValue+10, toValue: self.needleValue-10, duration: 0.4, callBack: {
                self.animate(triangleLayer: triangleLayer, shadowLayer: shadowLayer, fromValue: self.needleValue-10, toValue: self.needleValue, duration: 0.6, callBack: {})
            })
        }
    }
    
    func animate(triangleLayer: CAShapeLayer, shadowLayer:CAShapeLayer, fromValue: CGFloat, toValue:CGFloat, duration: CFTimeInterval, callBack:@escaping ()->Void) {
        // 1
        CATransaction.begin()
        let spinAnimation1 = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation1.fromValue = radian(for: fromValue)
        spinAnimation1.toValue = radian(for: toValue)
        spinAnimation1.duration = duration
        spinAnimation1.fillMode = kCAFillModeForwards
        spinAnimation1.isRemovedOnCompletion = false
        
        CATransaction.setCompletionBlock {
            callBack()
        }
        // 2
        triangleLayer.add(spinAnimation1, forKey: "indeterminateAnimation")
        shadowLayer.add(spinAnimation1, forKey: "indeterminateAnimation")
        CATransaction.commit()
    }
    
    func radian(for area: CGFloat) -> CGFloat {
        let degrees = 2.4 * area // Entire Arc is of 240 degrees
        let radians = degrees * .pi/180
        return radians
    }
}

struct ArcModel {
    var startAngle: CGFloat!
    var endAngle: CGFloat!
    var strokeColor: UIColor!
    var arcCap: CGLineCap!
    var center: CGPoint!
}
