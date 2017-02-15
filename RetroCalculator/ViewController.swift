//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Jonathan Tsistinas on 3/29/16.
//  Copyright © 2016 Techinator. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation:Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath:  path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func numberPressed(_ btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(_ sender: Any){
        runningNumber = "\(0)"
        leftValString = "\(0)"
        rightValString = "\(0)"
        
    }

    func processOperation(_ op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
        if runningNumber != "" {
            rightValString = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            }
            
            leftValString = result
            outputLbl.text = result
        }
            
            currentOperation = op
            
        } else {
            //this is the first time an operator is pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

