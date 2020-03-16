//
//  MainViewController.swift
//  XO-game
//
//  Created by Anastasia Romanova on 06/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  @IBAction func gameWithComputerButtonWasPressed(_ sender: Any) {
    let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
    gameVC.opponent = .computer
    gameVC.gameType = .oneMark
    self.present(gameVC, animated: true, completion: nil)
  }
  
  @IBAction func gameWithHumanButtonWasPressed(_ sender: Any) {
    let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
    gameVC.opponent = .human
    gameVC.gameType = .fiveMarks
    self.present(gameVC, animated: true, completion: nil)
  }
  
}
