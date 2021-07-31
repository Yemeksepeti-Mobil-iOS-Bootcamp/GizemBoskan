//
//  TicketModel.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation

struct TicketModel {
    
    var passenger: PassengerModel
    var date: DateModel
    var time: TimeModel
    var seats: [Int]?
    var seatCount: Int = 0

    init(passenger: PassengerModel, date: DateModel, time: TimeModel) {
        self.passenger = passenger
        self.date = date
        self.time = time
    }
    
    public func compareIsTaken(takenSeatNumbers: [Int]) -> Bool {
        if let seats = seats {
            for item in seats {
                if takenSeatNumbers.contains(item) {
                    return true
                }
            }
        }

        return false
    }
    
    public mutating func reserveSeats(seatCount: Int) {
        if self.seatCount == 0 && seatCount > 0 && seatCount <= 5  {
            self.seatCount = seatCount
            self.seats = []
        }
    }

    public mutating func addSeat(number: Int) {
        if BusSeatManager.shared.seatNumbers.contains(number), let seatsCount = seats?.count, seatsCount < 5 {
            seats?.append(number)
        }
    }
    
    public mutating func removeSeat(number: Int) {
        seats?.removeAll(where: { $0 == number })
    }

    public func print() -> String {
        return "\(passenger.print()), \(date.print()), \(time.print()) | \(String(describing: seats ?? []))"
    }
    
}
