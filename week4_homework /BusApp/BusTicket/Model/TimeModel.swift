//
//  TimeModel.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation

struct TimeModel {
    
    private(set) var hours: Int = 0
    private(set) var minute: Int = 0
  
    public func setMinute(hour: Int) {
        
    }
    
    init(hours: Int, minute: Int) {
        if hours > 0 || hours <= 24 {
            self.hours = hours
        }
        
        if minute > 0 || minute <= 60 {
            self.minute = minute
        }
    }
    
    public func print() -> String {
        let printTime = "\(hours):\(minute)"
        return printTime
    }
}
