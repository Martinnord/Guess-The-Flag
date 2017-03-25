//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Martin Nordström on 2017-03-25.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var highScoreLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var scoreCounter = 0
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
        var highScoreDefault = UserDefaults.standard

        if (highScoreDefault.value(forKey: "highscore") != nil) {
            highScore = highScoreDefault.value(forKey: "highscore") as! Int
            highScoreLbl.text = String(format: "Highscore: %i", highScore) as String
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
    
        if sender.tag == correctAnswer {
            title = "Correct"
        } else {
            title = "Wrong"
        }
        
        scoreLbl.text = NSString(format: "Score: %i", score) as String
        if (score >= highScore) {
            highScore = score
            highScoreLbl.text = NSString(format: "Highscore: %i", highScore) as String
            
            var highScoreDefault = UserDefaults.standard
            highScoreDefault.setValue(highScore, forKey: "highscore")
            highScoreDefault.synchronize()
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}


















