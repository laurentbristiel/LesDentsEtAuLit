//
//  FirstViewController.swift
//  LesDentsEtAuLit
//
//  Created by Laurent bristiel on 01/12/15.
//  Copyright © 2015 Laurent bristiel. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {

    // We need 3 timers because each can be launched any time
    var timerLeft = NSTimer()
    var timerCenter = NSTimer()
    var timerRight = NSTimer()

    // we should go read that in the user defaults
    var duration = 180
    var timeLeft = 180
    var timeCenter = 180
    var timeRight = 180

    // is the kid brushing?
    var brushingLeft = false
    var brushingCenter = false
    var brushingRight = false
    
    // music player
    var player: AVAudioPlayer = AVAudioPlayer()
    var music_playing = false
    
    // Labels that display time left to brush
    @IBOutlet weak var timerLabelLeft: UILabel!
    @IBOutlet weak var timerLabelCenter: UILabel!
    @IBOutlet weak var timerLabelRight: UILabel!

    // slider to dynamically set the duration
    @IBOutlet weak var sliderValue: UISlider!
    @IBAction func durationChanged(sender: AnyObject) {
        duration = Int(sliderValue.value) * 5
        resetLeft()
        resetCenter()
        resetRight()
    }

    @IBAction func ResetButton(sender: AnyObject) {
        resetLeft()
        resetCenter()
        resetRight()
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
    
    func launch_music(audioPath : String){
        print("launching music")
        stop_music_if_playing()
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            player.play()
            music_playing = true
        } catch {
            print("error player")
        }
    }

    func stop_music_if_playing(){
        if music_playing {
            print("stopping music")
            player.stop()
        }
    }

    
    // three next function to replace by generic one (see previous)
    func decreaseTimerLeft(){
        if(timeLeft > 1) {
            timeLeft--
            timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        } else if timeLeft == 1 {
            timeLeft--
            timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
            let audioPath = NSBundle.mainBundle().pathForResource("StarWars", ofType: "mp3")!
            launch_music(audioPath)
        }
    }
    
    func decreaseTimerCenter(){
        if(timeCenter > 1) {
            timeCenter--
            timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        } else if timeCenter == 1 {
            timeCenter--
            timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
            let audioPath = NSBundle.mainBundle().pathForResource("SurMaRoute", ofType: "mp3")!
            launch_music(audioPath)
        }

    }
    
    func decreaseTimerRight(){
        if(timeRight > 1) {
            timeRight--
            timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
        } else if timeRight == 1 {
            timeRight--
            timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
            let audioPath = NSBundle.mainBundle().pathForResource("ReineNeige", ofType: "mp3")!
            launch_music(audioPath)
        }
    }

    @IBAction func leftTimerButton(sender: AnyObject) {
        resetLeft()
    }

    @IBAction func centerTimerButton(sender: AnyObject) {
        resetCenter()
    }
    
    
    @IBAction func RightTimerButton(sender: AnyObject) {
        resetRight()
    }
    
    
    @IBAction func goLeft(sender: AnyObject) {
        if brushingLeft == false {
            brushingLeft = true
            timerLeft = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerLeft"), userInfo: nil, repeats: true)
        }
        else {
            brushingLeft = false
            timerLeft.invalidate()
        }
    }

    @IBAction func goCenter(sender: AnyObject) {
        if brushingCenter == false {
            brushingCenter = true
            timerCenter = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerCenter"), userInfo: nil, repeats: true)
        }
        else {
            brushingCenter = false
            timerCenter.invalidate()
        }
    }
    
    @IBAction func goRight(sender: AnyObject) {
        if brushingRight == false {
            brushingRight = true
            timerRight = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTimerRight"), userInfo: nil, repeats: true)
        }
        else
        {
            brushingRight = false
            timerRight.invalidate()
        }
        
    }
    
    func resetLeft(){
        brushingLeft = false
        timerLeft.invalidate()
        timeLeft = duration
        timerLabelLeft.text = secondsToMinutesSecondsString(timeLeft)
        stop_music_if_playing()
    }
    
    func resetCenter(){
        brushingCenter = false
        timerCenter.invalidate()
        timeCenter = duration
        timerLabelCenter.text = secondsToMinutesSecondsString(timeCenter)
        stop_music_if_playing()
    }
    
    func resetRight(){
        brushingRight = false
        timerRight.invalidate()
        timeRight = duration
        timerLabelRight.text = secondsToMinutesSecondsString(timeRight)
        stop_music_if_playing()
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

