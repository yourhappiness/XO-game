//
//  ComputerInputState.swift
//  XO-game
//
//  Created by Anastasia Romanova on 05/10/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

private class Move {
  var index: GameboardPosition?
  var score: Int?
}

public class ComputerInputState: GameState {
  
  var isCompleted: Bool = false
  
  var player: Player = .second
  var inputState: GameViewInput
  
  weak var gameboard: Gameboard?
  weak var gameboardView: GameboardView?
  
  var referee: Referee
  
  init(inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardView, referee: Referee) {
    self.inputState = inputState
    self.referee = referee
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func begin() {
    self.inputState.firstPlayerTurnLabel(hide: true)
    self.inputState.secondPlayerTurnLabel(hide: false)
    self.inputState.winnerLabel(hide: true)
    self.choosePosition()
  }
  
  func addMark(at position: GameboardPosition) {
    if true == self.gameboard?.containsAnyPlayer(at: position) { return }
    
    self.gameboard?.setPlayer(self.player, at: position)
    
    let markView = self.player.markViewPrototype.makeCopy()
    switch self.player {
    case .first:
      markView.lineColor = .red
    case .second:
      markView.lineColor = .green
    }
    DispatchQueue.main.async {
      self.gameboardView?.placeMarkView(markView, at: position)
    }
    
    self.isCompleted = true
  }
  
  func choosePosition() {
    var position: GameboardPosition?
    guard let gameboard = self.gameboard?.makeCopy() else {return}
    
    let computerStrategy = Int(arc4random_uniform(4))
    
    if computerStrategy == 0 {
      let emptyPositions = gameboard.returnEmptyPositions()
      let range = emptyPositions.count
      let index = Int(arc4random_uniform(UInt32(range)))
      position = emptyPositions[index]
      
      if let position = position {
        self.addMark(at: position)
      }
    } else {
      DispatchQueue.global().sync {
        let result = self.minimax(gameboard: gameboard, player: self.player)
        guard let movePosition = result.1?.index else {return}
        position = movePosition
        
        if let position = position {
          self.addMark(at: position)
        }
      }
    }
  }
  
  //Функция для просчитывания возможных результатов хода на текущем поле
  fileprivate func minimax(gameboard: Gameboard, player: Player) -> (Int?, Move?) {
    let emptyPositions = gameboard.returnEmptyPositions()
    //Проверка выигрышных комбинаций на доске
    if self.referee.doesPlayerHaveWinningCombination(gameboard: gameboard, player: .first) {
      return (-10, nil)
    } else if self.referee.doesPlayerHaveWinningCombination(gameboard: gameboard, player: .second) {
      return (10, nil)
    } else if emptyPositions.count == 0 {
      return (0, nil)
    } else {
    //Если выигрышных комбинаций на текущем поле нет, перебираются пустые клетки
      var moves: [Move] = []
      for position in emptyPositions {
        let move = Move()
        move.index = position
        //В пустую клетку выполняется ход
        gameboard.setPlayer(player, at: position)
        
        //И просчитываются результаты хода
        let result = self.minimax(gameboard: gameboard, player: player.next)
        if let score = result.0 {
          move.score = move.score ?? 0 + score
        } else if let bestMove = result.1 {
          guard let score = bestMove.score else {continue}
          move.score = move.score ?? 0 + score
        }
        
        //Ход очищается с доски
        gameboard.clearPosition(position)
        //Результаты хода добавляются в массив
        moves.append(move)
      }
      
      //Выбор наилучшего хода из массива
      var bestMove: Int?
      switch player {
      case .second:
        var bestScore = -10000
        for index in 0...(moves.count - 1) {
          guard let score = moves[index].score else {continue}
          if score > bestScore {
            bestScore = score
            bestMove = index
          }
        }
      case .first:
        var bestScore = 10000
        for index in 0...(moves.count - 1) {
          guard let score = moves[index].score else {continue}
          if score < bestScore {
            bestScore = score
            bestMove = index
          }
        }
      }
      
      guard let index = bestMove else {return (nil, nil)}
      return (nil, moves[index])
    }
  }
}
