//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Christopher Shackleton on 22/01/2020.
//  Copyright © 2020 Christopher Shackleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hiscoreLabel: UILabel!
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var kennyArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let hiscore = UserDefaults.standard.object(forKey: "hiscore")
        if hiscore == nil {
            hiscoreLabel.text = "0"
        }
        
        if let scoreValue = hiscore as? Int {
            hiscoreLabel.text = String(scoreValue)
        }
        
        scoreLabel.text = "Score: \(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(self.increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        // timer logic
        
        counter = 30
        timeLabel.text = String(counter)
        
        setTimers()
        
        // array logic
        
        kennyArray.append(kenny1)
        kennyArray.append(kenny2)
        kennyArray.append(kenny3)
        kennyArray.append(kenny4)
        kennyArray.append(kenny5)
        kennyArray.append(kenny6)
        kennyArray.append(kenny7)
        kennyArray.append(kenny8)
        kennyArray.append(kenny9)
        
        hideKenny()
    }
    
    func setTimers() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countdown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            // checking hiscores
            
            if self.score > Int(hiscoreLabel.text!)! {
                
                UserDefaults.standard.set(self.score, forKey: "hiscore")
                hiscoreLabel.text = String(self.score)
            }
            
            // end game alert
            
            let alert = UIAlertController(title: "Time", message: "Your time is up!", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                self.setTimers()
            }
            alert.addAction(replay)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[randomNumber].isHidden = false
    }


}

