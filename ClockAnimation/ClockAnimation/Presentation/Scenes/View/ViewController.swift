//
//  ViewController.swift
//  ClockAnimation
//
//  Created by MacBook  on 09.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    private var clockFace : Clock?
    var time: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClock()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        changeBackgroundColor()
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        clockFace?.setTime(datePicker.date)
        changeBackgroundColor()
    }
    
    private func setupClock() {
        clockFace = Clock()
        clockFace?.position = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 3)
        if let clockFace = clockFace {
            view.layer.addSublayer(clockFace)
        }
        clockFace?.setTime(Date())
    }
    
    private func getCurrentTime()  -> Int {
        self.time = datePicker.date
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var components = DateComponents()
        if let time = time {
            components = calendar.components([.NSHourCalendarUnit, .NSMinuteCalendarUnit], from: time)
        }
        let hour: CGFloat = CGFloat((Double((components.hour)!) / 12.0) * 2.0 * .pi)
        return Int(hour * 2)
    }
    
    
    private func changeBackgroundColor() {
        let currentHour = getCurrentTime()
        
        switch currentHour {
        case 0...6:
            view.backgroundColor = UIColor.darkGray
        case 7...12:
            view.backgroundColor = UIColor.systemTeal
        case 13...18:
            view.backgroundColor = UIColor.systemYellow
        case 19...24:
            view.backgroundColor = UIColor.lightGray
        default:
            view.backgroundColor = UIColor.white
            
        }
    }
}

