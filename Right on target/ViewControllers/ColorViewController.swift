//
//  ColorViewController.swift
//  Right on target
//
//  Created by Леон Алексанянц on 06.08.2021.
//

import UIKit

class ColorViewController: UIViewController, GameControllersProtocol {

    // MARK: - Переменные
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    // Сущность игры
    var game: Game<ColorRound>!
    
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(.Color(roundsCount: 5))
        updateLabelText(game.getCurrentSecretValue()?.hexValue ?? "")
        fillPaintButtons()
    }
    
    // MARK: - Взаимодействие с игрой
    @IBAction private func checkButton(_ sender: UIButton) {
        game.updateRoundScore(with: (sender.backgroundColor ?? .black, nil))
        
        if game.isGameEnded {
            showAlert(game.getGameScore())
            game.restartGame()
        } else {
            game.startNewRound()
        }
        
        updateLabelText(game.getCurrentSecretValue()?.hexValue ?? "")
        fillPaintButtons()
    }
    
    @IBAction private func closeGame() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Взаимодействие с интерфейсом
    private func updateLabelText(_ newText: String) {
        label.text = newText
    }
    
    private func fillPaintButtons() {
        let correctButton = (0...3).randomElement()!
        let buttons: [UIButton] = [button1, button2, button3, button4]
        
        for (index, button) in buttons.enumerated() {
            if index == correctButton {
                button.backgroundColor = game.getCurrentSecretValue()?.colorValue
            } else {
                button.backgroundColor = game.getRandomValue()?.colorValue
            }
        }
    }
    
    private func showAlert(_ score: Int) {
        let alertController = UIAlertController(title: "Конец игры", message: "Очков заработано: \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
