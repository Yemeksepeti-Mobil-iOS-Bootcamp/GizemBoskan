//
//  PassengerModel.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation

struct PassengerModel {
    
    var passengerName: String = "İsimsiz"
    var passengerSurname: String = "İsimsiz"
    var passengerId: Int = 0
    
    public func print() -> String {
        let printPassenger = "\(passengerName) - \(passengerSurname) - \(passengerId)"
        return printPassenger
    }
    
}
