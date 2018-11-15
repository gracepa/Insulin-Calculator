//
//  CalculateViewController.swift
//  Insulin Dose Calc
//
//  Created by Grace Park on 11/7/18.
//  Copyright © 2018 Grace Park. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var dailyInsulin: Int = 0
    var correctionFactor: Int = 0
    var carbIntake: Int = 0
    var bloodGlucose: Int = 0
    var mealInsulinDose: Int = 0
    var bolusInsulinDose: Int = 0
    var totalInsulinDose: Int = 0
    
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var carbSlider: UISlider!
    @IBOutlet weak var mealInsulinDoseLabel: UILabel!
    @IBAction func carbSliderValue(_ sender: UISlider) {
        carbIntake = Int(sender.value)
        carbLabel.text = "\(carbIntake)"
        mealInsulinDoseLabel.text = "\(calculateMealInsulin(carbAmount: carbIntake))"
        totalInsulinDoseLabel.text = "\(calculateTotalInsulinDose(mealIn: mealInsulinDose, bolusIn: bolusInsulinDose))"
    }
    
    @IBOutlet weak var bgLevelLabel: UILabel!
    @IBOutlet weak var bgLevelSlider: UISlider!
    @IBOutlet weak var bolusInsulinDoseLabel: UILabel!
    @IBAction func bgLevelSliderValue(_ sender: UISlider) {
        bloodGlucose = Int(sender.value)
        bgLevelLabel.text = "\(bloodGlucose)"
        bolusInsulinDoseLabel.text = "\(calculateBolusInsulin(bG: bloodGlucose))"
        totalInsulinDoseLabel.text = "\(calculateTotalInsulinDose(mealIn: mealInsulinDose, bolusIn: bolusInsulinDose))"
    }
    
    @IBOutlet weak var totalInsulinDoseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func calculateMealInsulin(carbAmount: Int) -> Int{
        mealInsulinDose = carbAmount / (500 / dailyInsulin)
        return mealInsulinDose
    }
    
    func calculateBolusInsulin(bG: Int) -> Int{
        if bloodGlucose >= 120 && correctionFactor > 0 {
            bolusInsulinDose = (bloodGlucose - 90) / correctionFactor
            return bolusInsulinDose
        } else {
            return bolusInsulinDose
        }
    }
    
    func calculateTotalInsulinDose(mealIn: Int, bolusIn: Int) -> Int{
        totalInsulinDose = mealIn + bolusIn
        return totalInsulinDose
    }

    @IBAction func seeHistoryButton(_ sender: Any) {
        performSegue(withIdentifier: "goToHistoryScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistoryScreen" {
            let history = segue.destination as! HistoryViewController
            history.saveDateTime = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
            history.saveCarbIntake = carbIntake
            history.saveBloodGlu = bloodGlucose
            history.saveInsulinDose = totalInsulinDose
           
        }
        
    }
   

}
