//
//  ViewController.swift
//  ClockAnimation
//
//  Created by MacBook  on 09.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    private var clockFace : ClockFace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clockFace = ClockFace()
        
        guard  let clockFace = clockFace else { return }
        clockFace.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3)
        
        view.layer.addSublayer(clockFace)
        clockFace.setTime(Date())

    }


    @IBAction func chooseTime(_ sender: Any) {
        clockFace?.setTime(datePicker.date)

    }
}

