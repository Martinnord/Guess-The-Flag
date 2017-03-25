//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Martin Nordström on 2017-03-25.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import GameKit // Gets me the randomize functions
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0 // Type inference

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds a border around the flags. (CALayer don't understand what UIColor is)
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // Changes the bordercolor with UIColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        // Will shuffel the order in the array
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        // 1.Assigns a UIImage to the button.
        // 2.Read from an array by position
        // 3. Which state of the button should be changes: The standard state of the button
        // 4.".normal" - Enum. "setImage" expects a UIControlState so we give it .normal
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button2.setImage(UIImage(named: countries[2]), for: .normal)
        
        // Generates a random number between 0-2, so one of the tree flags can be correct
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "CORRECT"
            score += 1
        } else {
            title = "WRONG"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

















