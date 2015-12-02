//
//  FirstViewController.swift
//  LesDentsEtAuLit
//
//  Created by Laurent bristiel on 01/12/15.
//  Copyright © 2015 Laurent bristiel. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController {

    // We need 3 timers because each can be launched any time
    var timerLeft = NSTimer()
    var timerCenter = NSTimer()
    var timerRight = NSTimer()

    // we should go read that in the user defaults
    var duration=180
    var timeLeft = 180
    var timeCenter = 180
    var timeRight = 180
    
    // Labels that display time to go
    @IBOutlet weak var timerLabelLeft: UILabel!
    @IBOutlet weak var timerLabelCenter: UILabel!
    @IBOutlet weak var timerLabelRight: UILabel!

    // slider to dynamically set the duration
    @IBOutlet weak var sliderValue: UISlider!
    @IBAction func durationChanged(sender: AnyObject) {
        duration = Int(sliderValue.value) * 10
        timeLeft = duration
        timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        timeCenter = duration
        timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        timeRight = duration
        timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
    }

    func secondsToMinutesSecondsString (seconds : Int) -> String {
        var secondsString:String
        if seconds < 0 {
            secondsString = "00"
        }
        else if (seconds % 60) < 10 {
            secondsString = "0"+String(seconds % 60)
        }
        else {
            secondsString = String(seconds % 60)
        }
        return String(seconds/60)+":"+secondsString
    }
    
    // generic decrease timer function that should be used by our timer
    // we need to pass argument to our selector in our timer
    // see http://stackoverflow.com/questions/24889279/passing-parameters-to-a-method-called-by-nstimer-in-swift
    func decreaseTimer(timerLabel:UILabel, inout time:Int) {
        if(time > 0) {
            time--
            timerLabel.text = secondsToMinutesSecondsString(time)
        }
    }
    
    // three next function to replace by generic one (see previous)
    func decreaseTimerLeft(){
        if(timeLeft > 0) {
            timeLeft--
            timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        }
    }
    
    func decreaseTimerCenter(){
        if(timeLeft > 0) {
            timeCenter--
            timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        }
    }
    
    func decreaseTimerRight(){
        if(timeRight > 0) {
            timeRight--
            timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
        }
    }
    
    @IBAction func goLeft(sender: AnyObject) {
        timeLeft = duration
        timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        timerLeft.invalidate()
        timerLeft = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerLeft"), userInfo: nil, repeats: true)
    }

    @IBAction func goCenter(sender: AnyObject) {
        timeCenter = duration
        timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        timerCenter.invalidate()
        timerCenter = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerCenter"), userInfo: nil, repeats: true)
    }
    
    @IBAction func goRight(sender: AnyObject) {
        timeRight = duration
        timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
        timerRight.invalidate()
        timerRight = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerRight"), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

