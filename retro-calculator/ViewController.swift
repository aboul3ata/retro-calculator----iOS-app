//
//  ViewController.swift
//  retro-calculator
//
//  Created by Ali Abouelatta on 6/3/17.
//  Copyright © 2017 Ali Abouelatta. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var btnSound: AVAudioPlayer!
    enum Operation: String {
        case Divide = "/"
        case Mulitply = "*"
        case Subract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningnumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    
     @IBOutlet weak var outputlbl: UILabel!

    @IBAction func clearbtnpressed(_ sender: Any) {
        
        runningnumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outputlbl.text = "0"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputlbl.text = "0"
        
    }

    @IBAction func numberPressed(sender:UIButton){
    playSound()
        
    runningnumber += "\(sender.tag)"
        outputlbl.text = runningnumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Mulitply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }

    


    

    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty{
        
        if runningnumber != ""{
            rightValStr = runningnumber
            runningnumber = ""
            
            if currentOperation == Operation.Mulitply{
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Subract{
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Add{
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputlbl.text = result
            
        }
            currentOperation = operation
        } else {
        
        leftValStr = runningnumber
        runningnumber = ""
        currentOperation = operation
        
        
        }
     
    
    }

}

