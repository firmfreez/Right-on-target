//
//  ViewController.swift
//  Right on target
//
//  Created by Леон Алексанянц on 05.08.2021.
//

import UIKit



class SliderViewController: UIViewController, GameControllersProtocol {

    // MARK: - Переменные
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    // сущность игры
    var game: Game<SliderRound>!
    
    // MARK: - Жизненный цикл
    // Объявление новой игры
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(minValue: 1, maxValue: 50, rounds: 5)
        updateLabelText(String(game.getCurrentSecretValue() ?? 0))
    }


    // MARK: - Взаимодействие с моделью
    // Функция проверки слайдера и подсчета очков (Бизнес логика игры)
    @IBAction func checkNumber() {
        game.updateRoundScore(with: Int(slider.value.rounded()))

        if game.isGameEnded {
            showAlert(game.getGameScore())
            // TODO: Пофиксить (Не нравится, что тут тоже надо min и max value передавать)
            
            game.restartGame(.Slider(minValue: 1, maxValue: 50))
        } else {
            game.startNewRound(.Slider(minValue: 1, maxValue: 50))
        }

        updateLabelText(String(game.getCurrentSecretValue() ?? 0))
    }
    
    @IBAction private func closeGame() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Изменение отображения VIEW
    // Показывает всплывающий диалог
    private func showAlert(_ score: Int) {
        let alertController = UIAlertController(title: "Конец игры", message: "Очков заработано: \(score)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Новая игра", style: .default, handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    // Обновляет текст с очками
    private func updateLabelText(_ newText: String) {
        label.text = newText
    }
}

