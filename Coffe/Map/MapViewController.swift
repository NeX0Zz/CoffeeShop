//
//  MapViewController.swift
//  Coffe
//
//  Created by Денис Николаев on 01.11.2024.
//
       
import UIKit
import YandexMapsMobile
import SnapKit

class MapViewController: UIViewController {
    
    var mapView: YMKMapView!
    var coffeeShop: [CoffeeShop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        title = "Карта"
        view.backgroundColor = .systemBackground
        
        addPlacemarks(mapView.mapWindow.map)
        
        if let firstShop = coffeeShop.first, let latitude = firstShop.point.latitudeDouble, let longitude = firstShop.point.longitudeDouble {
            let targetPoint = YMKPoint(latitude: latitude, longitude: longitude)
            mapView.mapWindow.map.move(
                with: YMKCameraPosition(target: targetPoint, zoom: 14, azimuth: 0, tilt: 0),
                animation: YMKAnimation(type: .smooth, duration: 1.5),
                cameraCallback: nil
            )
        }
    }
    
    private func setupMapView() {
        mapView = YMKMapView()
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func addPlacemarks(_ map: YMKMap) {
        for shop in coffeeShop {
            guard let latitude = shop.point.latitudeDouble, let longitude = shop.point.longitudeDouble else { continue }
            
            let point = YMKPoint(latitude: latitude, longitude: longitude)
            let placemark = map.mapObjects.addPlacemark(with: point)
            
            placemark.setIconWith(UIImage(named: "1") ?? UIImage())
            placemark.isDraggable = false
            placemark.userData = shop.name
            placemark.setTextWithText(shop.name, style: YMKTextStyle(size: 16,
                                                                     color: UIColor.ColorText,
                                                                     outlineWidth: 0.0,
                                                                     outlineColor: .white,
                                                                     placement: .bottom,
                                                                     offset: 0.0,
                                                                     offsetFromIcon: true,
                                                                     textOptional: false)
            )
            placemark.addTapListener(with: self)
        }
    }
}

extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let shopName = mapObject.userData as? String {
            print("Tapped on coffee shop: \(shopName)")
        }
        return true
    }
}
