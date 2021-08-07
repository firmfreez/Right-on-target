//
//  StartViewController.swift
//  Right on target
//
//  Created by Леон Алексанянц on 06.08.2021.
//

import UIKit

protocol GameControllersProtocol {}

class StartViewController: UIViewController {
    
    // Типы доступных игр
    enum GameControllers: String {
        case slider = "SliderViewController"
        case color = "ColorViewController"
    }
    
    // Ссылки на контроллеры с доступными играми
    private weak var sliderGame: SliderViewController? = nil
    private weak var colorGame: ColorViewController? = nil
    
    // Показывает игру со слайдером по нажатии на кнопку "Slider"
    @IBAction func showSliderGame() {
        if sliderGame == nil {
            sliderGame = getGameController(game: .slider)
        }
        
        present(sliderGame!, animated: true, completion: { [weak self] in
            self?.sliderGame = nil
        })
    }
    
    // Показывает игру с цветами по нажатии на кнопку "Color"
    @IBAction func showColorGame() {
        if colorGame == nil {
            colorGame = getGameController(game: .color)
        }
        
        present(colorGame!, animated: true, completion: { [weak self] in
            self?.colorGame = nil
        })
    }
    
    // Возвращает(Инициализирует) контроллер в зависимости от типа игры
    private func getGameController<T: GameControllersProtocol>(game: GameControllers) -> T {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(identifier: game.rawValue) as! T
    }
    
    private func getSliderViewController() -> SliderViewController {
        return SliderViewController()
    }
    
    private func getColorViewController() -> ColorViewController {
        return ColorViewController()
    }

}
