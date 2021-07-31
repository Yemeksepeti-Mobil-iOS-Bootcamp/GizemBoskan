//
//  BusSeatViewController.swift
//  BusTicket
//
//  Created by Gizem Boskan on 27.07.2021.
//

import UIKit

class BusSeatViewController: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var availableExampleView: BusSeatCell!
    @IBOutlet weak var chosenExampleView: BusSeatCell!
    @IBOutlet weak var takenExampleView: BusSeatCell!
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Otobüs Biletleri"
        availableExampleView.configure(busSeatAvailability: .available)
        chosenExampleView.configure(busSeatAvailability: .chosen)
        takenExampleView.configure(busSeatAvailability: .taken)
        
        availableExampleView.seatNumber.text = "BOŞ"
        chosenExampleView.seatNumber.text = "SEÇİLİ"
        takenExampleView.seatNumber.text = "DOLU"
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "DEVAM", style: .plain, target: self, action: #selector(buyTapped))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TicketManager.shared.ticket.reserveSeats(seatCount: 5)
        configureHierarchy()
        configureDataSource()
    }
    
    @objc func buyTapped() {
        if let seats = TicketManager.shared.ticket.seats, seats.isEmpty {
            let alert = UIAlertController(title: "HATA", message: "Lütfen koltuk seçiniz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BuyViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension BusSeatViewController {
    /// - Tag: Grid
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(200))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: BusSeatViewController.sectionHeaderElementKind, alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension BusSeatViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGray6
        collectionView.layer.cornerRadius = 40
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionContainerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: collectionContainerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: collectionContainerView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: collectionContainerView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionContainerView.bottomAnchor)
        ])
    }
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<BusSeatCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.configure(busSeatAvailability: BusSeatManager.shared.takenSeatNumbers.contains(indexPath.item + 1) ? .taken : .available)
            cell.seatNumber.text = "\(indexPath.item + 1)"
            cell.seatNumber.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        let emptyCellRegistration = UICollectionView.CellRegistration<BusSeatCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.configure()
        }
        
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: BusSeatViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.configure()
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            if (indexPath.item - 1) % 4 != 0 {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: emptyCellRegistration, for: indexPath, item: identifier)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<60))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
