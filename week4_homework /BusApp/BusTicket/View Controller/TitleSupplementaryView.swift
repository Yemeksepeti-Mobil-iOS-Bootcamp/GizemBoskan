//
//  TitleSupplementaryView.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import Foundation
import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    let headerView = UIImageView()
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        headerView.backgroundColor = .clear
        headerView.image = UIImage(named: "busHeader.png")
        headerView.contentMode = .scaleAspectFill
        headerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
