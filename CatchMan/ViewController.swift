//
//  ViewController.swift
//  CatchMan
//
//  Created by Buhtan on 25.03.2023.
//  Copyright © 2023 Buhtan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var kennyArray = [UIImageView]()
    var skore=0
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var skoreLabel: UILabel!
    @IBOutlet weak var highSkoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highSkoreLabel.text = "HighScore:\(self.highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highSkoreLabel.text = "HighScore:\(self.highScore)"
        }
        
        
        skoreLabel.text="Skore:\(skore)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseSkore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
    
    @objc func hideKenny(){
        
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        print(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.skore > self.highScore{
               self.highScore = self.skore
               highSkoreLabel.text = "HighScore:\(self.highScore)"
               UserDefaults.standard.set(self.highScore, forKey: "hihgScore")
            }
            
            let alert = UIAlertController(title: "Time's up", message: "Do you want play ?", preferredStyle: UIAlertController.Style.alert)
            
            let okeyButton = UIAlertAction(title: "Okey" ,style: UIAlertAction.Style.cancel, handler: nil)
            
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.skore = 0
                self.skoreLabel.text = "Skore:\(self.skore)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(replayButton)
            alert.addAction(okeyButton)
            self.present(alert,animated: true,completion: nil)
            
        }
        
    }
    @objc func increaseSkore(){
        skore += 1
        
        skoreLabel.text="Skore:\(skore)"
        
    }


}

