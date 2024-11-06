//
//  CartItemCell.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//

import UIKit
import SnapKit

class CartItemCell: UITableViewCell {
    static let identifier = "CartItemCell"
    var onAddToCartTapped: (() -> Void)?
    var onRemoveFromCartTapped: (() -> Void)?
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorTable
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.ColorText
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.ColorText2
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor.ColorText
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("–", for: .normal)
        button.setTitleColor(UIColor.ColorText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.ColorText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(quantityLabel)
        containerView.addSubview(minusButton)
        containerView.addSubview(plusButton)
        
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.trailing.equalTo(plusButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
        }
        
        minusButton.snp.makeConstraints { make in
            make.trailing.equalTo(quantityLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupActions() {
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    @objc private func didTapMinusButton() {
        onRemoveFromCartTapped?()
       }
    
    @objc private func didTapPlusButton() {
         onAddToCartTapped?()
    }
    
    func configure(with item: MenuItem, quantity: Int) {
        nameLabel.text = item.name
        priceLabel.text = "\(item.price * quantity) руб"
        quantityLabel.text = "\(quantity)"
    }
}
