//
//  QuestionViewController.swift
//  FortuneTeller
//
//  Created by Mindy Douglas on 6/8/21.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var choiceA: UITextField!
    @IBOutlet weak var choiceB: UITextField!
    @IBOutlet weak var choiceC: UITextField!
    @IBOutlet weak var choiceD: UITextField!
    @IBOutlet weak var choiceE: UITextField!
    @IBOutlet weak var choiceF: UITextField!
    @IBOutlet weak var choiceG: UITextField!
    @IBOutlet weak var choiceH: UITextField!
    @IBOutlet weak var questionStackView: UIStackView!
    
    // this constraint ties an element at zero points from the bottom
   // @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    var modelController: ModelController!
    
    // declare a variable to keep track of  current active text field
    var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        
        // Notification center observers will be used to animate our text fields up when the keyboard blocks them
        // right before keyboard is shown, notification named keyboardWillShowNotification will be sent to active UIResponder containing info about keyboard size that can be used to calculate how much distance to move upwards
        NotificationCenter.default.addObserver(self, selector: #selector(QuestionViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // when user dismisses keyboard, this notification happens that can be used to set frame origin back to 0
        NotificationCenter.default.addObserver(self, selector: #selector(QuestionViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // add delegate to all textfields to self
        questionTextField.delegate = self
        choiceA.delegate = self
        choiceB.delegate = self
        choiceC.delegate = self
        choiceD.delegate = self
        choiceE.delegate = self
        choiceF.delegate = self
        choiceG.delegate = self
        choiceH.delegate = self
    }
    
    // accessing UIResponder.keyboardFrameEndUserInfoKey gets us the frame of the keyboard from the userInfo dictionary of the notification (after the animation has ended)
    // we use keyboardSize's height to move the root view Y origin upward
    // compare activeTextField's maxY  (bottomY) value to visibleRange and move up only when bottomY is larger than visible range (bottomY value of textfield is larger than bottomY value of visible range)
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        var shouldMoveViewUp = false
        
        // if active text field is not nil
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            // if the bottom of texfield is below top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            
            // move the root view up by the distance of keyboard height
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back root view origin to zero
        self.view.frame.origin.y = 0
    }

  
    private func configureTextFields() {
        choiceA.delegate = self
        choiceB.delegate = self
        choiceC.delegate = self
        choiceD.delegate = self
        choiceE.delegate = self
        choiceF.delegate = self
        choiceG.delegate = self
        choiceH.delegate = self
        questionTextField.delegate = self
    }
    
    
/*  // hides keyboard when user taps away
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
*/

    @IBAction func submitButtonPressed(_ sender: Any) {
        
        // modelController.FortuneTeller.question = questionTextField.text
        // capture data from array modelController.FortuneTeller.answerChoices = [choiceA.text, ... choiceH.text]
        
        guard let question = questionTextField.text,
              let answer1 = choiceA.text,
              let answer2 = choiceB.text,
              let answer3 = choiceC.text,
              let answer4 = choiceD.text,
              let answer5 = choiceE.text,
              let answer6 = choiceF.text,
              let answer7 = choiceG.text,
              let answer8 = choiceH.text else {
            return
        }

        modelController.fortune.question = question
        
        modelController.fortune.answerChoices = [answer1, answer2, answer3, answer4, answer5,
        answer6, answer7, answer8]
            
        view.endEditing(true)
       
    }
    
    // prepare for segue set model controller of next view to model controller of this view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectionViewController = segue.destination as? SelectionViewController {
            selectionViewController.modelController = modelController
        }
    }

}

extension QuestionViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // when user selects textfield, this method is called
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // set activeTextField to selected text field
        self.activeTextField = textField
    }
    
    // when user clicks "done" or dismiss the keyboard
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
}

