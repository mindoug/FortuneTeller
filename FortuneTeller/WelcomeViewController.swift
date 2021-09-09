//
//  WelcomeViewController.swift
//  FortuneTeller
//
//  Created by Mindy Douglas on 6/8/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var modelController: ModelController!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
            questionViewController.modelController = modelController
        }
    }

}
