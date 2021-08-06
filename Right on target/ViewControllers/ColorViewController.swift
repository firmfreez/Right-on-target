//
//  ColorViewController.swift
//  Right on target
//
//  Created by Леон Алексанянц on 06.08.2021.
//

import UIKit

class ColorViewController: UIViewController, GameControllersProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction private func closeGame() {
        self.dismiss(animated: true, completion: nil)
    }
}
