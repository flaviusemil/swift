//
//  ViewController.swift
//  Stopwatch
//
//  Created by Flavius Condurache on 18/06/15.
//  Copyright (c) 2015 Flavius Condurache. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var time: UILabel!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var playPause: UIBarButtonItem!
    @IBOutlet var stopButton: UIBarButtonItem!
    
    var timer: NSTimer = NSTimer()
    var count: Int = 0
    var status: Bool = false
    var started: Bool = false
    var playStatus: Bool = false
    
    
    @IBAction func playPauseClicked(sender: AnyObject) {
        togglePlayPause()
    }
    
    @IBAction func resetClicked(sender: AnyObject) {
        timer.invalidate()
        count = 0
        started = false
        stopButton.enabled = false
        if status == true && started == false {
            togglePlayPause()
        }
        time.text = "0"
    }
    
    func tickAndUpdate() {
        count++
        time.text = String(count)
    }
    
    func togglePlayPause() {
        status = !status
        toggleImageButton(status)
    }
    
    func toggleImageButton(status: Bool) {
        var toggleBtn: UIBarButtonItem
        var items = toolBar.items!
        if status == false {
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "togglePlayPause")
            items[0] = toggleBtn
        } else if status == true {
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "togglePlayPause")
            items[0] = toggleBtn
        } else {
            println("The status variable is in a invalid format!")
        }
        toolBar.setItems(items, animated: true)
        toggleActions()
    }
    
    func toggleActions() {
        if status == true {
            if playStatus == false {
                play()
                stopButton.enabled = true
                playStatus != playStatus
            }
        } else if status == false {
            pause()
            playStatus == false
        }
    }
    
    func play() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("tickAndUpdate"), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

