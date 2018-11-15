//
//  HistoryData.swift
//  Insulin Dose Calc
//
//  Created by Grace Park on 11/9/18.
//  Copyright © 2018 Grace Park. All rights reserved.
//

import Foundation

class HistoryData: Codable {
    var dateTime : String = ""
    var carbIn: Int = 0
    var bloodGlu: Int = 0
    var insulinDose: Int = 0
}

