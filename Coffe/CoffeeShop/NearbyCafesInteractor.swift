//
//  NearbyCafesInteractor.swift
//  Coffe
//
//  Created by Денис Николаев on 31.10.2024.

import Foundation
import Moya
import CoreLocation

class NearbyCafesInteractor: NSObject, NearbyCafesInteractorProtocol, CLLocationManagerDelegate {
    private let provider = MoyaProvider<CafeAPI>()
    weak var presenter: NearbyCafesInteractorOutputProtocol?
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var hasFetchedInitialCafes = false 

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func startLocationUpdates() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            presenter?.didFailFetchingCoffeeShops(with: "Доступ к местоположению запрещен. Пожалуйста, включите доступ в настройках.")
        @unknown default:
            presenter?.didFailFetchingCoffeeShops(with: "Неизвестная ошибка доступа к местоположению.")
        }
    }

    func fetchNearbyCafes(latitude: Double = 55.7558, longitude: Double = 37.6176) {
        provider.request(.nearbyCafes(lat: latitude, lon: longitude)) { result in
            switch result {
            case .success(let response):
                do {
                    let coffeeShops = try JSONDecoder().decode([CoffeeShop].self, from: response.data)
                    self.presenter?.didFetchCoffeeShops(coffeeShops)
                    self.calculateDistances(for: coffeeShops)
                } catch {
                    self.presenter?.didFailFetchingCoffeeShops(with: "Ошибка декодирования: \(error)")
                }
            case .failure(let error):
                self.presenter?.didFailFetchingCoffeeShops(with: error.localizedDescription)
            }
        }
    }

    internal func calculateDistances(for coffeeShops: [CoffeeShop]) {
        

        let coffeeShopsWithDistance = coffeeShops.compactMap { shop -> (CoffeeShop, CLLocationDistance)? in
            guard let lat = shop.point.latitudeDouble, let lon = shop.point.longitudeDouble else { return nil }
            let shopLocation = CLLocation(latitude: lat, longitude: lon)
            let distance = currentLocation!.distance(from: shopLocation)
            return (shop, distance)
        }
        presenter?.didFetchCoffeeShopsWithDistance(coffeeShopsWithDistance)
    }
}

extension NearbyCafesInteractor {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        currentLocation = latestLocation
        locationManager.stopUpdatingLocation()

        if !hasFetchedInitialCafes {
            hasFetchedInitialCafes = true
            fetchNearbyCafes(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presenter?.didFailFetchingCoffeeShops(with: "Ошибка определения местоположения: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            startLocationUpdates()
        } else {
            presenter?.didFailFetchingCoffeeShops(with: "Доступ к местоположению запрещен.")
        }
    }
}
