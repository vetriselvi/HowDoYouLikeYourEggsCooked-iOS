//
//  ViewController.swift
//  EggTimer
//
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]//300,420,720
    
    /*let softTime = 5
    let mediumTime = 7
    let hardTime = 12*/
    
    var cookTime = 0
    var count = 0
    var timer = Timer()
    
    let initialTitle = "How do you like your eggs?"
    @IBOutlet weak var progressViewEgg: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        
     
        
        timer.invalidate()
        
        
        let hardness = sender.currentTitle!
        count = eggTimes[hardness]!
        
        titleLabel.text = hardness
        
      /*  if hardness == "Soft" {
            cookTime = softTime
        } else if hardness == "Medium" {
            cookTime = mediumTime
        } else if hardness == "Hard" {
            cookTime = hardTime
        } */
        
        switch hardness {
        case "Soft":
            cookTime = eggTimes["Soft"]!
        case "Medium":
            cookTime = eggTimes["Medium"]!
        case "Hard":
            cookTime = eggTimes["Hard"]!
        default:
            print("Error")
        }
        
        //timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        
       
    }
    
    @objc func updateTimer() {
        if(count>0) {
            print("Counting down: \(count) seconds left")
            count=count-1
            progressViewEgg.progress = 1-Float(count)/Float(cookTime)
        }
        if(count==0){
            timer.invalidate()
            titleLabel.text="Done!"
            progressViewEgg.progress = 1
            
            let alert = UIAlertController(title: "Egg Timer", message: "Cooking time is up!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            playSound()
            
        }
    }//end updateTimer()
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
            guard let player = player else { return }
            player.play()

        } catch {
            print("error with the alarm sound")
        }
    }//end playSound()

        
       
//        if(count==0) {
//            print("Done!")
//            
//        }
    }


