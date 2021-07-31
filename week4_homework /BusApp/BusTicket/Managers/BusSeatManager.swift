//
//  BusSeatManager.swift
//  BusTicket
//
//  Created by Gizem Boskan on 25.07.2021.
//

import Foundation

class BusSeatManager {
    
    static let shared = BusSeatManager()

    private init() {
        getSeatNumbers()
    }
    
    enum Constants {
        static let seatCount: Int = 45
    }

    var takenSeatNumbers = [Int]()
    var seatNumbers = [Int]()
    
    func generateBoughtSeats(){
        let boughtSeatCount = Int.random(in: 10...Constants.seatCount)
        for _ in 1...boughtSeatCount{
            getBoughtSeatNumber()
        }
    }
    
    private func getBoughtSeatNumber() {
        if let boughtSeatNumber = seatNumbers.randomElement() {
            if !takenSeatNumbers.contains(boughtSeatNumber) {
                takenSeatNumbers.append(boughtSeatNumber)
            }
        }
    }
    
    
    private func getSeatNumbers() {
        seatNumbers.removeAll()
        takenSeatNumbers.removeAll()
        for index in 0...59 {
            if (index - 1) % 4 != 0 {
                seatNumbers.append(index + 1)
            }
        }
    }
}
