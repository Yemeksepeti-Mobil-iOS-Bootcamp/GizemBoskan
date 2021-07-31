//
//  DateModel.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation

struct DateModel {
    
    var day: Int = 1
    var month: Int = 1
    var year: Int = 2021
        
    init(day: Int, month: Int, year: Int) {
        if day > 0 || day <= 365 {
            self.day = day
        }
        
        if month > 0 || month <= 12 {
            self.month = month
        }
        
        if year >= 2021 {
            self.year = year
        }
    }

    public func print() -> String {
        let printDate = "\(day)/\(month)/\(year)"
        return printDate
    }
}
