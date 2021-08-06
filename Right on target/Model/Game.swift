//
//  Game.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import Foundation

// MARK: - ENUM-ы
enum RoundType {
    case Slider(minValue: Int, maxValue: Int)
    case Color
}

// MARK: - Протоколы
// Протокол игры
protocol GameProtocol {
    associatedtype Round: RoundProtocol
    
    var rounds: [Round] { get }
    var isGameEnded: Bool { get }
    
    func restartGame(_ type: RoundType)
    func startNewRound(_ type: RoundType)
}

// MARK: - Классы
// Класс игры
class Game<T: RoundProtocol>: GameProtocol {
    var rounds: [T]
    private var lastRound: Int
    
    var isGameEnded: Bool {
        if rounds.count >= lastRound {
            return true
        } else {
            return false
        }
    }
    

    init?(minValue: Int, maxValue: Int, rounds: Int) where T == SliderRound {
        self.rounds = []
        lastRound = rounds
        startNewRound(.Slider(minValue: minValue, maxValue: maxValue))
    }
    
    
    func startNewRound(_ type: RoundType) {
        switch type {
        case let .Slider(minValue, maxValue):
            // TODO: Пофиксить. Не нравится кастование к T
            rounds.append(SliderRound(minSecretValue: minValue, maxSecretValue: maxValue) as! T)
        case .Color:
            rounds.append(ColorRound() as! T)
        }
    }
    
    
    func restartGame(_ type: RoundType) {
        rounds = []
        startNewRound(type)
    }
    
    
    func getCurrentSecretValue() -> T.Generator.ValueType? {
        return rounds.last?.currentSecretValue
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
