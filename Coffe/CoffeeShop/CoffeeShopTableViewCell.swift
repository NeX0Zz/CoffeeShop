//
//  CoffeeShopTableViewCell.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import UIKit
import CoreLocation

class CoffeeShopTableViewCell: UITableViewCell {
    
    static let identifier = "CoffeeShopTableViewCell"
    
    private let nameLabel = UILabel()
    private let distanceLabel = UILabel()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.88, alpha: 1.0)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
        }
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = UIColor.ColorText
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        distanceLabel.font = UIFont.systemFont(ofSize: 14)
        distanceLabel.textColor = UIColor.colorText2
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            distanceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with coffeeShop: CoffeeShop, distance: CLLocationDistance) {
        nameLabel.text = coffeeShop.name
        distanceLabel.text = String(format: "Расстояние: %.1f м", distance)
    }
}

