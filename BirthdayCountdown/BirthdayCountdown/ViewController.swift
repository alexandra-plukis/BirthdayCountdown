//
//  ViewController.swift
//  BirthdayCountdown
//
//  Created by Alexandra Plukis on 10/8/19.
//  Copyright © 2019 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetLabels()
    }
    
    func sentinelFunc() {
        //hello!! this is to show version control :^)
    }
    

    
    // called whenever the date changes && the name isn't empty
    // or called whenever the name changes (default is current date, countdown is 0)
    func calculateCountdown(today: Date, birthday: Date) -> Int {
        let calendarDifference = Calendar.current.dateComponents([.day, .hour], from: today, to: birthday)
        if let daysRemaining = calendarDifference.day {
            if let hoursRemaining = calendarDifference.hour {
                if (daysRemaining == 0 && hoursRemaining == 0) {
                    alert()
                    return daysRemaining
                }
                else if (daysRemaining < 0 ) {
                    return -100 // sentinel value
                }
                else {
                    return daysRemaining + 1
                }
            } else { return daysRemaining }
        } else {
            return -1
        }
    }
    
    func alert() {
        if let name = nameField.text {
            alertLabel.text = "Call " + name + " today!"
        } else {
            alertLabel.text = "Today is their birthday!"
        }
    }
    
    // set on "value changed"
    @IBAction func grabDate(_ sender: UIDatePicker) {
        driveReminder()
    }
    
    // set on "value changed"
    @IBAction func grabName(_ sender: Any) {
        driveReminder()
    }
    
    func updateCountdown(daysLeft: Int, name: String)
    {
        countdownLabel.text = "\(daysLeft) Days Until \(name)'s Birthday"
    }
    
    func resetLabels() {
        countdownLabel.text = "Enter a Birthday and Name"
        alertLabel.text = ""
        nameField.placeholder = "Name"
    }
    
    func driveReminder() {
        let dateChosen = datePicker.date
        let currentDate = Date()
        resetLabels()
        if let name = nameField.text {
            if (name != "") {
                let days = calculateCountdown(today: currentDate, birthday: dateChosen)
                if (days < 0) {
                    resetLabels()
                    countdownLabel.text = "You have missed \(name)'s birthday >:-/"
                }
                else {
                    updateCountdown(daysLeft: days, name: name)
                }
                
            }
        } else {
            return
        }
    }
    

    
}

