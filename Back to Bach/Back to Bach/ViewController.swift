//
//  ViewController.swift
//  Back to Bach
//
//  Created by Flavius Condurache on 22/06/15.
//  Copyright (c) 2015 Flavius Condurache. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var volumeControl: UISlider!
    @IBOutlet var playPause: UIBarButtonItem!
    @IBOutlet var stop: UIBarButtonItem!
    @IBOutlet var toolbar: UIToolbar!
    
    var state: Int = 0
    
    @IBAction func volumeChanged(sender: AnyObject) {
        player.volume = volumeControl.value
    }
    
    @IBAction func playPause(sender: AnyObject) {
        
        if sender.tag == 1 {
            state = 1
        } else if sender.tag == 0 {
            state = 0
        }
        
        var toggleBtn: UIBarButtonItem
        var items = toolbar.items!
        if state == 0 {
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "playPause:")
            toggleBtn.tag = 1
            items[0] = toggleBtn
        } else if state == 1 {
            toggleBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "playPause:")
            toggleBtn.tag = 0
            items[0] = toggleBtn
            state = 0
        } else {
            println("The status variable is in a invalid format!")
        }
        toolbar.setItems(items, animated: true)
        
        if sender.tag == 1 {
            player.play()
            stop.enabled = true
        } else if sender.tag == 0 {
            player.pause()
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
        stop.enabled = false
        player.currentTime = 0
        state = 0
        if playPause.tag == 1 {
            playPause.tag = 0
            playPause(playPause)
        }
    }
    
    var player: AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var path = NSBundle.mainBundle().pathForResource("bach1", ofType: "mp3")
        var error: NSError? = nil
        var url = NSURL(fileURLWithPath: path!)
        
        player = AVAudioPlayer(contentsOfURL: url, error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

