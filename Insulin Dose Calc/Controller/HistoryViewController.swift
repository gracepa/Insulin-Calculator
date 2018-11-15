//
//  HistoryViewController.swift
//  Insulin Dose Calc
//
//  Created by Grace Park on 11/7/18.
//  Copyright © 2018 Grace Park. All rights reserved.
//

import UIKit


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var historyArray = [HistoryData]()
    var historyDataPoint = HistoryData()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("HistoryPoints.plist")
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var saveDateTime : String = ""
    var saveCarbIntake: Int = 0
    var saveBloodGlu: Int = 0
    var saveInsulinDose: Int = 0
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var carbIntakeLabel: UILabel!
    @IBOutlet weak var bloodGluLabel: UILabel!
    @IBOutlet weak var insulinDoseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTimeLabel.text = saveDateTime
        carbIntakeLabel.text = "\(saveCarbIntake)"
        bloodGluLabel.text = "\(saveBloodGlu)"
        insulinDoseLabel.text = "\(saveInsulinDose)"
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")

        loadHistory()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        //        historyArray = [HistoryData.init(dateTime: "", bloodGlu: 0, insulinDose: 0)]
        
        cell.dateTimeLabel.text = historyArray[indexPath.row].dateTime
        cell.carbLabel.text = "\(historyArray[indexPath.row].carbIn)"
        cell.bgLabel.text = "\(historyArray[indexPath.row].bloodGlu)"
        cell.totalInsulinLabel.text = "\(historyArray[indexPath.row].insulinDose)"
        return cell
    }
  // cite Angela Yu
    func loadHistory() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                historyArray = try decoder.decode([HistoryData].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        historyDataPoint.dateTime = saveDateTime
        historyDataPoint.carbIn = saveCarbIntake
        historyDataPoint.bloodGlu = saveBloodGlu
        historyDataPoint.insulinDose = saveInsulinDose
        historyArray.append(historyDataPoint)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.historyArray)
            try data.write(to: dataFilePath!)
        } catch {
            print ("Error encoding item array, \(error)")
        }
        historyTableView.reloadData()
    // cite Angela Yu
    }
}
