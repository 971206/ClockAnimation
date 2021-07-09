//
//  ClockFace.swift
//  ClockAnimation
//
//  Created by MacBook  on 09.07.21.
//

import UIKit
import QuartzCore


class Clock: CAShapeLayer {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var time: Date?
    private var hourHand: CAShapeLayer?
    private var minuteHand: CAShapeLayer?
    private var shapeLayer: CAShapeLayer?
    
    
    override init() {
        super.init()
        bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        path = UIBezierPath(ovalIn: bounds).cgPath
        fillColor = UIColor.white.cgColor
        strokeColor = UIColor.black.cgColor
        lineWidth = 4
        
        hourHand = CAShapeLayer()
        hourHand?.path = UIBezierPath(rect: CGRect(x: -2, y: -70, width: 4, height: 70)).cgPath
        hourHand?.fillColor = UIColor.black.cgColor
        hourHand?.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        if let hourHand = hourHand {
            addSublayer(hourHand)
        }
        
        minuteHand = CAShapeLayer()
        minuteHand?.path = UIBezierPath(rect: CGRect(x: -1, y: -90, width: 2, height: 90)).cgPath
        minuteHand?.fillColor = UIColor.black.cgColor
        minuteHand?.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        if let minuteHand = minuteHand {
            addSublayer(minuteHand)
        }
        strokeToAnimate()
    }
    
    func setTime(_ time: Date?) {
        self.time = time
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var components = DateComponents()
        guard let time = time else {return}
        components = calendar.components([.NSHourCalendarUnit, .NSMinuteCalendarUnit], from: time)
        guard let currentHour = components.hour else {return}
        guard let currentMinute = components.minute else {return}
        let minuteInDecimal = currentMinute / 60
        
        let hour = CGFloat((Double(currentHour) / 12.0) * 2.0 * .pi)
        let minutes = CGFloat((Double(currentMinute) / 60.0) * 2.0 * .pi)
        
        self.hourHand?.setAffineTransform(CGAffineTransform(rotationAngle: hour))
        self.minuteHand?.setAffineTransform(CGAffineTransform(rotationAngle: minutes))
        
        if currentHour > 12 {
            strokeAnimation(to: Double(currentHour + minuteInDecimal - 12 ) / 12)
        } else {
            strokeAnimation(to: Double(currentHour + minuteInDecimal) / 12)
        }
    }
    
    private func strokeToAnimate() {
        shapeLayer = CAShapeLayer()
        guard let shapeLayer = shapeLayer else {return}
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 100,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: -(.pi / 2) + .pi * 2,
                                        clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        addSublayer(shapeLayer)
    }
    
    private func strokeAnimation(to value: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        removeAnimation()
        animation.fromValue = 0.0
        animation.toValue = value
        animation.duration = 2
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer?.add(animation, forKey: "animatingStroke")
    }
    
    func removeAnimation() {
        shapeLayer?.removeAnimation(forKey: "animatingStroke")
    }
}
