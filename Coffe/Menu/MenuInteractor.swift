//
//  MenuInteractor.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.


import Foundation
import Moya

class MenuInteractor: MenuInteractorProtocol {
    weak var presenter: MenuPresenterProtocol?
    private let provider = MoyaProvider<MenuService>()
  
    func getMenu(locationId: String) {
        provider.request(.getMenu(locationId: locationId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let menuItems = try JSONDecoder().decode([MenuItem].self, from: response.data)
                    if menuItems.isEmpty {
                        self.presenter?.didFailToFetchMenu(error: "Меню пустое.")
                    } else {
                        self.presenter?.didFetchMenu(menuItems: menuItems)
                    }
                } catch {
                    self.presenter?.didFailToFetchMenu(error: "Ошибка декодирования данных: \(error.localizedDescription)")
                }
            case .failure(let error):
                self.presenter?.didFailToFetchMenu(error: "Ошибка сети: \(error.localizedDescription)")
            }
        }
    }
}
