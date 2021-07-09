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
    
    func getCurrentTime()  -> Int{
        self.time = datePicker.date
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var components: DateComponents? = nil
        if let time = time {
            components = calendar.components([.NSHourCalendarUnit, .NSMinuteCalendarUnit], from: time)
        }
        let hour: CGFloat = CGFloat((Double((components?.hour)!) / 12.0) * 2.0 * .pi)
        return Int(hour * 2)
    }

    
    func changeBackgroundColor() {
        let currentHour = getCurrentTime()
        if  0 < currentHour  && currentHour <= 6 {
            view.backgroundColor = UIColor.darkGray
        } else if 6 < currentHour || currentHour <= 12 {
            view.backgroundColor = UIColor.systemBlue
        } else if  12 < currentHour && currentHour <= 18{
            view.backgroundColor = UIColor.systemYellow
        } else if 18 < currentHour && currentHour < 24 {
            view.backgroundColor = UIColor.lightGray
        }
    }


    @IBAction func chooseTime(_ sender: UIDatePicker) {
        clockFace?.setTime(datePicker.date)
        changeBackgroundColor()
    }
    
    
}

