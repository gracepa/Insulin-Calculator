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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "historyCell")

        loadHistory()
        
        save()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let headerLabel = UILabel(frame: CGRect(x: 6, y: 6, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana Bold", size: 14)
        headerLabel.textColor = UIColor.black
        headerLabel.text = "Date, Carb Intake, Blood Glucose, Insulin Dose"
        headerLabel.sizeToFit()
        header.addSubview(headerLabel)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        
        cell.dateTimeLabel.text = historyArray[indexPath.row].dateTime
        cell.carbLabel.text = "\(historyArray[indexPath.row].carbIn)"
        cell.bgLabel.text = "\(historyArray[indexPath.row].bloodGlu)"
        cell.totalInsulinLabel.text = "\(historyArray[indexPath.row].insulinDose)"
        return cell
    }

   
    
/* Title: Todoey
 Author: Angela Yu, londappbrewery
 Date: 2018
 Availability: https://github.com/londonappbrewery/Todoey
 */
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

    func save() {
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
    }
    
    @IBAction func startOverButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
    }
    
}
