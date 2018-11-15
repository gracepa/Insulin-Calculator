//
//  WeightViewController.swift
//  Insulin Dose Calc
//
//  Created by Grace Park on 11/7/18.
//  Copyright © 2018 Grace Park. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {
    
    var weight: Int = 0
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBAction func weightSliderValue(_ sender: UISlider) {
        weight = Int(sender.value)
        weightLabel.text = "\(weight)"
        dailyInsulinLabel.text = "\(calculateDailyInsulin(wt: weight))"
        correctionFactorLabel.text = "\(calculateCorrectionFactor(wt: weight))"
    }
    
    @IBOutlet weak var dailyInsulinLabel: UILabel!
    @IBOutlet weak var correctionFactorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "goToCalcScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCalcScreen" {
            let calculator = segue.destination as! CalculateViewController
            calculator.dailyInsulin = calculateDailyInsulin(wt: weight)
            calculator.correctionFactor = calculateCorrectionFactor(wt: weight)
        }
    }
    
    func calculateDailyInsulin(wt: Int) -> Int{
        let dailyInsulin: Int = weight / 4
        return dailyInsulin
    }
    
    func calculateCorrectionFactor(wt: Int) -> Int{
        var correctFac: Int = 0
        if weight > 0 {
            correctFac = 1800 / (weight/4)
            return correctFac
        } else {
            return correctFac
        }
    }

}
