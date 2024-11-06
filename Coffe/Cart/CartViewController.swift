//
//  CartViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//


import UIKit
import SnapKit

class CartViewController: UIViewController, CartViewProtocol {
    func showCartItems(_ items: [MenuItem]) {
        self.items = items
        tableView.reloadData()
        updateViewForEmptyCart()
    }

    var presenter: CartPresenterProtocol?
    private var items: [MenuItem] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private let estimatedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время ожидания заказа\n15 минут!\nСпасибо, что выбрали нас!"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.ColorText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let payButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        button.layer.cornerRadius = 24.5
        button.layer.borderWidth = 2.0
        button.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        return button
    }()
    
    private let emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите товар"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.colorText
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ваш заказ"
        view.backgroundColor = .white
        items = presenter?.getCartItems() ?? []
        setupTableView()
        setupEstimatedTimeLabel()
        setupPayButton()
        setupEmptyCartLabel()
        
        updateViewForEmptyCart()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-280)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupEstimatedTimeLabel() {
        view.addSubview(estimatedTimeLabel)
        
        estimatedTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    private func setupPayButton() {
        view.addSubview(payButton)
        
        payButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }
    }
    
    private func setupEmptyCartLabel() {
        view.addSubview(emptyCartLabel)
        
        emptyCartLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func updateViewForEmptyCart() {
        let isCartEmpty = items.isEmpty
        tableView.isHidden = isCartEmpty
        estimatedTimeLabel.isHidden = isCartEmpty
        emptyCartLabel.isHidden = !isCartEmpty
        payButton.isHidden = isCartEmpty
    }

    private func incrementQuantity(for index: Int) {
        guard index < items.count else { return }
        guard let quality = items[index].quality, quality > 0 else { return }
        
        items[index].quality = (items[index].quality ?? 0) + 1
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        updateViewForEmptyCart()
    }

    private func decrementQuantity(for index: Int) {
        guard index < items.count else { return }
        guard let quality = items[index].quality, quality > 0 else { return }
        
        items[index].quality! -= 1
        
        if items[index].quality == 0 {
            items.remove(at: index)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        } else {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        
        updateViewForEmptyCart()
    }
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item, quantity: item.quality ?? 1)
        cell.onAddToCartTapped = { [weak self] in
            self?.incrementQuantity(for: indexPath.row)
        }
        
        cell.onRemoveFromCartTapped = { [weak self] in
            self?.decrementQuantity(for: indexPath.row)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        return footerView
    }
}
