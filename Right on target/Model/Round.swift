//
//  Round.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import Foundation
import UIKit


// MARK: - ENUM-ы
enum RoundType {
    case Slider(minValue: Int, maxValue: Int, roundsCount: Int)
    case Color(roundsCount: Int)
    
    func getRoundsCount() -> Int {
        var rCount = 0
        
        switch self {
            case let .Slider(_, _, roundsCount):
                rCount = roundsCount
            case let .Color(roundsCount):
                rCount = roundsCount
        }
        
        return rCount
    }
    
    func getRoundInstance<T: RoundProtocol>() -> T {
        switch self {
        case let .Slider(minValue, maxValue, _):
            return SliderRound(minSecretValue: minValue, maxSecretValue: maxValue) as! T
        case .Color:
            return ColorRound() as! T
        }
    }
}


// MARK: - Протоколы
protocol RoundProtocol {
    associatedtype Generator: GeneratorProtocol
    
    var score: Int { get }
    var currentSecretValue: Generator.ValueType { get }
    var generator: Generator { get }
    
    func calculateScore(with: Generator.ValueType)
}


// MARK: - Классы
class SliderRound: RoundProtocol {
    typealias Generator = SimpleIntGenerator

    var score: Int = 0
    var generator: Generator
    var currentSecretValue: Generator.ValueType
    
    
    init?(minSecretValue: Generator.ValueType = 1, maxSecretValue: Generator.ValueType = 50) {
        generator = Generator()
        guard generator.setRange(from: minSecretValue, to: maxSecretValue) else {
            return nil
        }
        currentSecretValue = generator.generateValue()
    }

    func calculateScore(with value: Generator.ValueType) {
        if value > currentSecretValue {
            score += generator.maxValue - value + currentSecretValue
        } else if value < currentSecretValue {
            score += generator.maxValue - currentSecretValue + value
        } else {
            score += 50
        }
    }
}


class ColorRound: RoundProtocol {
    typealias Generator = SimpleColorGenerator
    
    var score: Int = 0
    var generator: Generator
    var currentSecretValue: Generator.ValueType
    
    init() {
        generator = Generator()
        currentSecretValue = generator.generateValue()
    }
    
    func calculateScore(with: Generator.ValueType) {
        if currentSecretValue.colorValue == with.colorValue {
            score += 1
        }
    }
}
