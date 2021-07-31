//
//  TicketManager.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation

class TicketManager {
    
    static let shared = TicketManager()

    private init() {}
    
    var ticket: TicketModel = TicketModel(passenger: PassengerModel(), date: DateModel(day: 15, month: 12, year: 2021), time: TimeModel(hours: 19, minute: 30))
    
    func reset() {
        ticket = TicketModel(passenger: PassengerModel(), date: DateModel(day: 15, month: 12, year: 2021), time: TimeModel(hours: 19, minute: 30))
    }
}
