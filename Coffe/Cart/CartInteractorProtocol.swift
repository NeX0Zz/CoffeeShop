//
//  CartInteractorProtocol.swift
//  Coffe
//
//  Created by Денис Николаев on 04.11.2024.
//


protocol CartInteractorProtocol: AnyObject {
    var presenter: CartPresenterProtocol? { get set }
    
}

// CartInteractor.swift
// Coffe

import Foundation

class CartInteractor: CartInteractorProtocol {
    weak var presenter: CartPresenterProtocol?

   
}
