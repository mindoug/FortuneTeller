//
//  SelectionViewController.swift
//  FortuneTeller
//
//  Created by Mindy Douglas on 6/6/21.
//

import UIKit

class SelectionViewController: UIViewController {
    
    @IBOutlet weak var choiceImageView: UIImageView!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var orange: UIButton!
    @IBOutlet weak var yellow: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var top: UIButton!
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var bottom: UIButton!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var numberButtons: UIButton!
    
    var selection: Int = 0
    var timesPressed = 0
    
    var modelController: ModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showColors()
        
        top.contentVerticalAlignment = .bottom
        bottom.contentVerticalAlignment = .top
    }
    
    // image loader function to load the images for the animation
    
    func animatedImages(for name: String) -> [UIImage] {
        var index = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)/\(index)") {
            images.append(image)
            index += 1
        }
        return images
    }
    
    // animates the images based on the selection (numberOfTimes)
    
    func animationSequence(numberOfTimes: Int) {
        choiceImageView.animationImages = animatedImages(for: "animate")
        choiceImageView.animationDuration = 0.6
        choiceImageView.animationRepeatCount = numberOfTimes
        choiceImageView.image = choiceImageView.animationImages?.first
        choiceImageView.startAnimating()
    }
    
    // when the color choices are displayed
    
    func showColors() {
        view.backgroundColor = .green
        selectionLabel.text = "Pick a color"
        blue.isEnabled = true
        orange.isEnabled = true
        yellow.isEnabled = true
        green.isEnabled = true
        blue.setTitle("Blue", for: .normal)
        orange.setTitle("Orange", for: .normal)
        yellow.setTitle("Yellow", for: .normal)
        green.setTitle("Green", for: .normal)
        top.isEnabled = false
        right.isEnabled = false
        bottom.isEnabled = false
        left.isEnabled = false
        top.setTitle("", for: .normal)
        right.setTitle("", for: .normal)
        bottom.setTitle("", for: .normal)
        left.setTitle("", for: .normal)
    }
    
    // when the number choices are shown
    
    func showNumbers() {
        view.backgroundColor = .orange
        selectionLabel.text = "Pick a number"
        blue.isEnabled = false
        orange.isEnabled = false
        yellow.isEnabled = false
        green.isEnabled = false
        blue.setTitle("", for: .normal)
        orange.setTitle("", for: .normal)
        yellow.setTitle("", for: .normal)
        green.setTitle("", for: .normal)
        top.isEnabled = true
        right.isEnabled = true
        bottom.isEnabled = true
        left.isEnabled = true
    }
    
    
    // either horizontal number image view or vertical one
    
    func showHorizontal() {
        choiceImageView.image = UIImage(named: "numberHorizontal")
        showNumbers()
    }
    
    func showVertical() {
        choiceImageView.image = UIImage(named: "numberVertical")
        showNumbers()
    }
   
    
    @IBAction func colorButtonrPressed(_ sender: UIButton) {
        switch sender.title(for: .normal) {
        case "Blue":
            animationSequence(numberOfTimes: 4)
            showHorizontal()
            
        case "Green":
            animationSequence(numberOfTimes: 5)
            showVertical()
           
        case "Orange":
            animationSequence(numberOfTimes: 6)
            showHorizontal()
         
        case "Yellow":
           animationSequence(numberOfTimes: 6)
            showHorizontal()
            
        default:
            print("error with color buttons")
        }
    }
  
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        showNumbers()
        
        if timesPressed < 2 {
            setSelection(sender)
            
            // animate image the number of times selected
            animationSequence(numberOfTimes: selection)
            
            // odd or even?  Show next image.
            if selection % 2 == 0 {
                showVertical()
            } else {
                showHorizontal()
            }
            
            // pick a number twice then go to answer view
            timesPressed += 1
            
            
        } else if timesPressed == 2 {
            setSelection(sender)
            
            // sets model's selection = selection view's selection
            modelController.fortune.selection = selection
            print("after 2 times selection = \(selection)")
            performSegue(withIdentifier: "Results", sender: nil)
            
        }
    }
    
    func setSelection(_ sender: UIButton) {
        switch sender {
        case top:
            if choiceImageView.image == UIImage(named: "numberHorizontal") {
                selection = 3
            } else {
                selection = 1
            }
        case bottom:
            if choiceImageView.image == UIImage(named: "numberHorizontal") {
                selection = 7
            } else {
                selection = 5
            }
        case left:
            if choiceImageView.image == UIImage(named: "numberHorizontal") {
                selection = 8
            } else {
                selection = 6
            }
        case right:
            if choiceImageView.image == UIImage(named: "numberHorizontal") {
                selection = 4
            } else {
                selection = 2
            }
        default:
            print("error")
        }

    }
    
    
    // prepare for segue set model controller of next view to model controller of this view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let answerViewController = segue.destination as? AnswerViewController {
            answerViewController.modelController = modelController
        }
    }
    
}
