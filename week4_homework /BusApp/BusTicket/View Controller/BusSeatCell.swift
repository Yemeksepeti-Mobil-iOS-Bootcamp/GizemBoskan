//
//  BusSeatCell.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import UIKit

enum BusSeatAvailability {
    case available, taken, chosen
}

class BusSeatCell: UICollectionViewCell {
    static let reuseIdentifier = "text-cell-reuse-identifier"

    let seatView = UIImageView()
    let seatNumber = UILabel()

    private var busSeatAvailability: BusSeatAvailability?
    private let seatImage = UIImage(named: "busSeat.png")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        if let busSeatAvailability = busSeatAvailability, state.isSelected {
            if busSeatAvailability == .taken {
                return
            } else if busSeatAvailability == .available {
                if let number = Int(seatNumber.text ?? "-1"), let count = TicketManager.shared.ticket.seats?.count, count < 5{
                    TicketManager.shared.ticket.addSeat(number: number)
                    changeAvailability(to: .chosen)
                }
            } else {
                if let number = Int(seatNumber.text ?? "-1") {
                    TicketManager.shared.ticket.removeSeat(number: number)
                    changeAvailability(to: .available)
                }
            }
        }
    }
    
    private func changeAvailability(to state: BusSeatAvailability) {
        switch state {
        case .available:
            seatView.image = seatImage
        case .taken:
            seatView.image = seatImage?.maskWithColor(color: .systemBlue)
        case .chosen:
            seatView.image = seatImage?.maskWithColor(color: .green)
        }
        self.busSeatAvailability = state
    }
}

extension BusSeatCell {
    func configure(busSeatAvailability: BusSeatAvailability) {
        self.busSeatAvailability = busSeatAvailability
        seatView.backgroundColor = .clear
        seatView.contentMode = .scaleToFill
        seatView.image = seatImage
        changeAvailability(to: busSeatAvailability)
        seatView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seatView)
        NSLayoutConstraint.activate([
            seatView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seatView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seatView.topAnchor.constraint(equalTo: contentView.topAnchor),
            seatView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        seatNumber.translatesAutoresizingMaskIntoConstraints = false
        seatNumber.adjustsFontForContentSizeCategory = true
        seatNumber.textAlignment = .center
        contentView.addSubview(seatNumber)
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            seatNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            seatNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            seatNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            seatNumber.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
    }
    
    func configure() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
    }
}
