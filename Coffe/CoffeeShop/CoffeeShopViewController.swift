//
//  CoffeeShopViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.
//

import UIKit
import SnapKit
import CoreLocation

class NearbyCafesViewController: UIViewController {
    var presenter: NearbyCafesPresenterProtocol?
    private let tableView = UITableView()
    private var coffeeShopsWithDistance: [(CoffeeShop, CLLocationDistance)] = []
    private var router: NearbyCafesRouterProtocol?
    private var coffeeShopData: [CoffeeShop]?
    
    private let mapButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ближайшие кофейни"
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.interactor?.startLocationUpdates()
    }
    
    @objc func showMap() {
        presenter?.interactor?.presenter?.navigateToMap(with: coffeeShopData!)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        mapButton.setTitle("На карте", for: .normal)
        mapButton.setTitleColor(UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1), for: .normal)
        mapButton.layer.cornerRadius = 24.5
        mapButton.layer.borderWidth = 2.0
        mapButton.backgroundColor = UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        mapButton.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        view.addSubview(mapButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoffeeShopTableViewCell.self, forCellReuseIdentifier: CoffeeShopTableViewCell.identifier)
        view.addSubview(tableView)
        
        mapButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalTo(mapButton.snp.top).offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        tableView.separatorStyle = .none
    }
}

extension NearbyCafesViewController: NearbyCafesViewProtocol {
    func displayCoffeeShops(_ coffeeShops: [CoffeeShop]) {
        self.coffeeShopsWithDistance = coffeeShops.map { ($0, 0.0) }
        self.coffeeShopData = coffeeShops
        self.tableView.reloadData()
    }
    
    func displayCoffeeShopsWithDistance(_ coffeeShops: [(CoffeeShop, CLLocationDistance)]) {
        self.coffeeShopsWithDistance = coffeeShops
        self.tableView.reloadData()
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
}

extension NearbyCafesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShopsWithDistance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeShopTableViewCell.identifier, for: indexPath) as! CoffeeShopTableViewCell
        let coffeeShopData = coffeeShopsWithDistance[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(with: coffeeShopData.0, distance: coffeeShopData.1)
        print(coffeeShopData.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoffeeShop = coffeeShopsWithDistance[indexPath.row].0
        presenter?.didSelectCoffeeShop(selectedCoffeeShop)
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
