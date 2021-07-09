//
//  ClockFace.swift
//  ClockAnimation
//
//  Created by MacBook  on 09.07.21.
//

import UIKit
import QuartzCore


class ClockFace: CAShapeLayer {
    var time: Date?
    private var hourHand: CAShapeLayer?
    private var minuteHand: CAShapeLayer?

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
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTime(_ time: Date?) {
        self.time = time
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        guard let time = time else {return}
        components = calendar.dateComponents([.hour, .minute], from: time)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        var hourTransform = hourHand?.affineTransform()
        var minuteTransform = minuteHand?.affineTransform()
        hourTransform = CGAffineTransform(rotationAngle: CGFloat(Double(hour) / 12.0 * 2.0) * .pi)
        minuteTransform = CGAffineTransform(rotationAngle: CGFloat(Double(minute) / 60.0 * 2.0) * .pi)
                
    }
}
