//
//  Game.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import Foundation

// MARK: - Протоколы
// Протокол игры
protocol GameProtocol {
    associatedtype Round: RoundProtocol
    
    var rounds: [Round] { get }
    var isGameEnded: Bool { get }
    
    func restartGame()
    func startNewRound()
}

// MARK: - Классы
// Класс игры
class Game<T: RoundProtocol>: GameProtocol {
    private var currentRoundType: RoundType
    
    var rounds: [T]
    var isGameEnded: Bool {
        if rounds.count >= currentRoundType.getRoundsCount() {
            return true
        } else {
            return false
        }
    }

    init(_ type: RoundType) {
        self.rounds = []
        currentRoundType = type
        startNewRound()
    }
    
    
    func startNewRound() {
        rounds.append(currentRoundType.getRoundInstance())
    }
    
    
    func restartGame() {
        rounds = []
        startNewRound()
    }
    
    
    func getCurrentSecretValue() -> T.Generator.ValueType? {
        return rounds.last?.currentSecretValue
    }
    
    func getRandomValue() -> T.Generator.ValueType? {
        return rounds.last?.generator.generateValue()
    }
    
    func updateRoundScore(with: T.Generator.ValueType) {
        rounds.last?.calculateScore(with: with)
    }
    
    func getGameScore() -> Int {
        var result = 0
        for round in rounds {
            result += round.score
        }
        return result
    }

}
