//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit


protocol GameViewInput {
    var opponent: GameOpponent {get set}
  
    func firstPlayerTurnLabel(hide: Bool)
    func secondPlayerTurnLabel(hide: Bool)
    
    func winnerLabel(hide: Bool)
    func winnerLabel(text: String)
}

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    
    @IBOutlet var restartButton: UIButton!
    
    let gameboard = Gameboard()
    lazy var referee = Referee(gameboard: self.gameboard)
  
    public var opponent: GameOpponent = .human
  
    public var gameType: GameType = .oneMark
    
    var currentPlayer: Player = .first
    
    var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
  
    private var gameOpponentStrategy: GameOpponentStrategy {
      return self.opponent.getOpponentStrategy()
    }
  
    private var gameTypeStrategy: GameTypeStrategy {
      return self.gameType.getGameTypeStrategy()
    }
  
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.gameTypeStrategy.switchToFirstState(viewController: self, player: .first)
      
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
          
            self.currentState.addMark(at: position)
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              self.gameTypeStrategy.switchToNextState(viewController: self)
            }
          }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        self.gameboard.clear()
        self.gameboardView.clear()
        
        self.currentPlayer = .first
        
        self.gameTypeStrategy.switchToFirstState(viewController: self, player: .first)
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
  // MARK: - State machine
  
    func swithToPlayerInputState(with player: Player) {
      switch player {
      case .first:
        self.currentState = PlayerInputState(player: player,
                                             inputState: self,
                                             gameboard: self.gameboard,
                                             gameboardView: self.gameboardView)
      case .second:
        self.currentState = self.gameOpponentStrategy.returnPlayerInputState(
          player: player,
          inputState: self,
          gameboard: self.gameboard,
          gameboardView: self.gameboardView,
          referee: self.referee)
        switch self.opponent {
        case .computer:
          self.gameTypeStrategy.switchToNextState(viewController: self)
        case .human:
          return
        }
      }
    }
  
    func swithToPlayerInputSeveralMarksState(with player: Player) {
      self.currentState = PlayerInputSeveralMarksState(player: player,
                                                       inputState: self,
                                                       gameboard: self.gameboard,
                                                       gameboardView: self.gameboardView)
    }
    
}


extension GameViewController: GameViewInput {
    
    func firstPlayerTurnLabel(hide: Bool) {
        self.firstPlayerTurnLabel.isHidden = hide
    }
    func secondPlayerTurnLabel(hide: Bool) {
        self.secondPlayerTurnLabel.isHidden = hide
    }
    
    func winnerLabel(hide: Bool)  {
        self.winnerLabel.isHidden = hide
    }
    func winnerLabel(text: String) {
        self.winnerLabel.text = text
    }
}
