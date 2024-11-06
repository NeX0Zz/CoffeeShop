//
//  MenuViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, MenuViewProtocol {
    
    var presenter: MenuPresenterProtocol?
    var items: [MenuItem] = [MenuItem(id: 1, name: "e", imageURL: "er", price: 12, quality: 1)]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48) / 2, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.identifier)
        return collectionView
    }()
    
    private let actionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Меню"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        presenter?.getMenu(locationId: "1")
    }
    
    @objc private func buttonTapped() {
        presenter?.goToCart(with: items)
    }
    
    private func setupCollectionView() {
        
        actionButton.setTitle("Перейти к оплате", for: .normal)
        actionButton.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        actionButton.layer.cornerRadius = 24.5
        actionButton.layer.borderWidth = 2.0
        actionButton.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        view.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(18)
            make.right.equalTo(view).inset(18)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view)                             
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(actionButton.snp.top)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func showMenu(_ menuItems: [MenuItem]) {
        self.items = menuItems
        collectionView.reloadData()
    }
    
    func showError(_ message: String) {
        print("Ошибка: \(message)")
    }
    
    private func incrementQuantity(for index: Int) {
        items[index].quality = (items[index].quality ?? 0) + 1
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }

    private func decrementQuantity(for index: Int) {
        guard let quality = items[index].quality, quality > 0 else { return }
        items[index].quality! -= 1
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.identifier, for: indexPath) as? MenuItemCell else {
            return UICollectionViewCell()
        }
        let menuItem = items[indexPath.row]
        cell.configure(with: menuItem)
        cell.onAddToCartTapped = { [weak self] in
            self?.incrementQuantity(for: indexPath.row)
        }
        
        cell.onRemoveFromCartTapped = { [weak self] in
            self?.decrementQuantity(for: indexPath.row)
        }
        return cell
    }
}
