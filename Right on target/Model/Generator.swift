//
//  Generator.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import Foundation
import UIKit

// MARK: - Протоколы
protocol GeneratorProtocol {
    associatedtype ValueType
    
    func generateValue() -> ValueType
}

protocol SliderGenerator: GeneratorProtocol where ValueType == Int {
    var minValue: ValueType! { get }
    var maxValue: ValueType! { get }
    
    func setRange(from: ValueType, to: ValueType) -> Bool
}

protocol ColorGenerator: GeneratorProtocol where ValueType == (colorValue: UIColor, hexValue: String?) {
    var hexedColor: String? { get }
}


// MARK: - Классы
class SimpleIntGenerator: SliderGenerator {
    var minValue: Int!
    var maxValue: Int!
    
    init() {
        minValue = 1
        maxValue = 50
    }
    
    func setRange(from: Int, to: Int) -> Bool {
        guard from < to else {
            return false
        }
        
        minValue = from
        maxValue = to
        
        return true
    }

    
    // Функция генерации числа
    func generateValue() -> Int {
        return (minValue...maxValue).randomElement()!
    }
}

class SimpleColorGenerator: ColorGenerator {
    var hexedColor: String? = nil
    
    func generateValue() -> (colorValue: UIColor, hexValue: String?) {
        let randomRed = CGFloat((1...255).randomElement()!)
        let randomBlue = CGFloat((1...255).randomElement()!)
        let randomGreen = CGFloat((1...255).randomElement()!)
        let hexRed = String(format: "%02X", Int(randomRed.rounded()))
        let hexBlue = String(format: "%02X", Int(randomBlue.rounded()))
        let hexGreen = String(format: "%02X", Int(randomGreen.rounded()))
        
        hexedColor = "#\(hexRed + hexBlue + hexGreen)"
        return (UIColor(red: randomRed / 255, green: randomGreen / 255, blue: randomBlue / 255, alpha: 1.0), hexedColor)
    }
}
