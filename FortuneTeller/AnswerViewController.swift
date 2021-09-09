//
//  AnswerViewController.swift
//  FortuneTeller
//
//  Created by Mindy Douglas on 6/6/21.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var labelE: UILabel!
    @IBOutlet weak var labelF: UILabel!
    @IBOutlet weak var labelG: UILabel!
    @IBOutlet weak var labelH: UILabel!
    
    var modelController: ModelController!
   
    
    var choice: Int = 1
    var numberLabel = ""
    var labels: [UILabel] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choice = modelController.fortune.selection
        questionLabel.text = modelController.fortune.question
        let randomAnswer = Int(modelController.fortune.answerChoices.randomElement()!)
        answerLabel.text = modelController.fortune.answerChoices[randomAnswer ?? 3]
        
        
        // OPTIONAL:  can be omitted if the labels are set and stay the same regardless of number selected
        // to assign a number to the labels so that the number selected appears to be at the top of the image
        // the selected number will appear as the top label, with the remaining labels filling in a number in clockwise direction
        // After the eighth label is set (choice + index < 9), the number label becomes (choice + index) - 8 in order to start the label numbers back to 1
        
        labels = [labelA, labelB, labelC, labelD, labelE, labelF, labelG, labelH]
        for index in 0...7 {
        if choice + index < 9 {
        numberLabel = String(choice + index)
        } else {
        numberLabel = String((choice + index) - 8)
        }
        labels[index].text = numberLabel
        }
    }
    
}
