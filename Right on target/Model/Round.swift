//
//  Round.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import Foundation
import UIKit

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
        if currentSecretValue == with {
            score += 1
        }
    }
}
